import { Stack, StackProps, aws_apigateway } from "aws-cdk-lib";
import { Construct } from "constructs";
import { stackConst, IStackConst } from "./environment";
import { Role, ServicePrincipal, ManagedPolicy } from "aws-cdk-lib/aws-iam";
import { NodejsFunction } from "aws-cdk-lib/aws-lambda-nodejs";
import { LambdaConfig, createNodejsFunction } from "./utils/lambdaCreator";
/**
 * cdk設定用インターフェースを拡張
 */
interface CdkStackProps extends StackProps {
  constant: IStackConst;
}

interface APIGatewayConfig {
  method:string;
  resourcePath: string;
}

interface ExtendLambdaConfig extends LambdaConfig {
  apiGateway: APIGatewayConfig;
}

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props?: CdkStackProps) {
    super(scope, id, props);

    /** ----------------------------------------
     * Lambda共通環境変数
     ---------------------------------------- */
    const lambdaEnvironmtntCommon = {
      REGION: props!.constant.awsRegion,
    };
    /** ----------------------------------------
     * Lambda個別設定用環境変数
     ---------------------------------------- */
    const LOCAL_ENV = {};

    /** ----------------------------------------
     * Lambda設定＋APIGateway設定
     ---------------------------------------- */
    const lambdaConfig: ExtendLambdaConfig[] = [
      {
        name: "getUser",
        filePath: "../apis/user/src/getUser.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
        apiGateway: {
          method:"GET",
          resourcePath: "user",
        },
      },
    ];
    /** ----------------------------------------
     * IAMロール設定
     ---------------------------------------- */
    const lambdaRole = new Role(this, "lambdaRole", {
      assumedBy: new ServicePrincipal("lambda.amazonaws.com"),
      roleName: "lambdaExecutionRole",
    });

    lambdaRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName("AdministratorAccess")
    );
    lambdaRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName("AWSLambdaExecute")
    );
    lambdaRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName("SecretsManagerReadWrite")
    );
    lambdaRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName("AmazonS3FullAccess")
    );
    lambdaRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName("AmazonSSMFullAccess")
    );
    lambdaRole.addManagedPolicy(
      ManagedPolicy.fromAwsManagedPolicyName(
        "service-role/AWSLambdaVPCAccessExecutionRole"
      )
    );

    /** ----------------------------------------
     * Lambdaデプロイ
     ---------------------------------------- */
    type lambdaFunctions = {
      [prop: string]: NodejsFunction;
    };
    let lambdaFn: lambdaFunctions = {};

    for (const curLambdaConfig of lambdaConfig) {
      lambdaFn[curLambdaConfig.name] = createNodejsFunction(
        this,
        curLambdaConfig,
        lambdaRole
      );
    }

    /** ----------------------------------------
     * APIGateway作成
     ---------------------------------------- */
    const apigateway = new aws_apigateway.RestApi(
      this,
      props!.constant.apigateway.name,
      {
        restApiName: props!.constant.apigateway.name,
        deployOptions: {
          dataTraceEnabled: true,
          metricsEnabled: true,
        },
      }
    );

    // 使用プラン作成
    const usagePlan = apigateway.addUsagePlan(props!.constant.apigateway.usagePlan);
    usagePlan.addApiStage({ stage: apigateway.deploymentStage });

    /** ----------------------------------------
     * APIGatewayメソッド作成
     ---------------------------------------- */
    type apiGatewayMethods = {
      [prop: string]: {
        [prop: string]: any;
      };
    };

    // APIGatewayメソッド格納用変数
    let apiGW: apiGatewayMethods = {};

    // リソースパスを作成
    const apiRootPath = apigateway.root.addResource("apis");

    for(const curLambdaConfig of lambdaConfig){
      if (!apiGW[curLambdaConfig.name]) {apiGW[curLambdaConfig.name] = {}; }
      apiGW[curLambdaConfig.name].resourcePath = apiRootPath.addResource(curLambdaConfig.apiGateway.resourcePath);
      apiGW[curLambdaConfig.name].integration = new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]);
      apiGW[curLambdaConfig.name].resourcePath.addMethod(curLambdaConfig.apiGateway.method,apiGW[curLambdaConfig.name].integration);
    }
    //
  }
}
