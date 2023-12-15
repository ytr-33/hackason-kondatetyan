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
      INGREDIENTS_TABLE_NAME : "tbl_ingredients",
      RECIPES_TABLE_NAME : "tbl_recipes",
    };
    /** ----------------------------------------
     * Lambda個別設定用環境変数
     ---------------------------------------- */
    const LOCAL_ENV = {};

    /** ----------------------------------------
     * Lambda設定＋APIGateway設定
     ---------------------------------------- */
    const lambdaConfig: LambdaConfig[] = [
      {
        name: "getIngredientList",
        filePath: "../apis/ingredients/src/getIngredientList.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "createIngredient",
        filePath: "../apis/ingredients/src/createIngredient.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "updateIngredient",
        filePath: "../apis/ingredients/{ingredient_id}/src/updateIngredient.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "deleteIngredient",
        filePath: "../apis/ingredients/{ingredient_id}/src/deleteIngredient.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "getRecipeList",
        filePath: "../apis/recipes/src/getRecipeList.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "createRecipe",
        filePath: "../apis/recipes/src/createRecipe.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "updateRecipe",
        filePath: "../apis/recipes/{recipe_id}/src/updateRecipe.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "deleteRecipe",
        filePath: "../apis/recipes/{recipe_id}/src/deleteRecipe.ts",
        environment: {
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "getRecipeProposal",
        filePath: "../apis/recipes/proposal/src/getRecipeProposal.ts",
        environment: {
          
          ...lambdaEnvironmtntCommon,
        },
      },
      {
        name: "createAiRecipeProposal",
        filePath: "../apis/recipes/proposal/ai-proposal/src/createAiRecipeProposal.ts",
        environment: {
          OPENAI_API_KEY: props!.constant.apiKey,
          OPENAI_API_MODEL:"gpt-3.5-turbo",
          ...lambdaEnvironmtntCommon,
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

    let curLambdaConfig:any ;
    const resourcePathIngredients = apiRootPath.addResource("ingredients");


    // GET
    curLambdaConfig = lambdaConfig[0]
    resourcePathIngredients.addMethod("GET",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name])
      );
    //POST
    curLambdaConfig = lambdaConfig[1]
    resourcePathIngredients.addMethod("POST", new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name])
      );

    const resourcePathIngredient = resourcePathIngredients.addResource("{ingredient_id}");
    // PUT
    curLambdaConfig = lambdaConfig[2]
    resourcePathIngredient.addMethod("PUT",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));
    // DELETE
    curLambdaConfig = lambdaConfig[3]
    resourcePathIngredient.addMethod("DELETE",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));

   const resourcePathRecipes = apiRootPath.addResource("recipes");
   
   // GET
   curLambdaConfig = lambdaConfig[4]
   resourcePathRecipes.addMethod("GET",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));
   //POST
   curLambdaConfig = lambdaConfig[5]
   resourcePathRecipes.addMethod("POST",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));

   const resourcePathRecipe = resourcePathRecipes.addResource("{recipe_id}");
   // PUT
   curLambdaConfig = lambdaConfig[6]
   resourcePathRecipe.addMethod("PUT",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));
   // DELETE
   curLambdaConfig = lambdaConfig[7]
   resourcePathRecipe.addMethod("DELETE", new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));


   
   const resourcePathRecipeProposal = resourcePathRecipes.addResource("proposal");
   // GET
   curLambdaConfig = lambdaConfig[8]
   resourcePathRecipeProposal.addMethod("POST",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));
  
      
   const resourcePathAiRecipeProposal = resourcePathRecipeProposal.addResource("ai-proposal");
   // GET
   curLambdaConfig = lambdaConfig[9]
   resourcePathAiRecipeProposal.addMethod("POST",new aws_apigateway.LambdaIntegration(lambdaFn[curLambdaConfig.name]));
  
   
  }
}
