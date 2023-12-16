import { RemovalPolicy, Stack, StackProps, aws_apigateway, aws_s3, aws_s3_deployment } from "aws-cdk-lib";
import { Construct } from "constructs";
import { IStackConst } from "./environment";
import { LambdaConfig,createNodejsFunction } from "./utils/lambdaCreator";
import * as iam from "aws-cdk-lib/aws-iam";
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb'
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as apigateway from 'aws-cdk-lib/aws-apigateway';
import * as s3 from 'aws-cdk-lib/aws-s3';
import * as s3_deployment from 'aws-cdk-lib/aws-s3-deployment';
import { NodejsFunction } from "aws-cdk-lib/aws-lambda-nodejs";
/**
 * cdk設定用インターフェースを拡張
 */
interface CdkStackProps extends StackProps {
  constant: IStackConst;
}

export class CdkStack extends Stack {
  constructor(scope: Construct, id: string, props?: CdkStackProps) {
    super(scope, id, props);

    /** ----------------------------------------
     * S3バケット
     ---------------------------------------- */
    const websiteBucket = new s3.Bucket(this, "kondatetyan-web", {
      removalPolicy: RemovalPolicy.RETAIN
    });
    
    
    
    /** ----------------------------------------
     * DynamoDBテーブル　
     ---------------------------------------- */
    const ingredientTable = new dynamodb.Table(this, 'IngredientTable', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.NUMBER },
      sortKey: { name: 'name', type: dynamodb.AttributeType.STRING },
      deletionProtection: true,
    });

    const recipeTable = new dynamodb.Table(this, 'RecipeTable', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.NUMBER },
      sortKey: { name: 'name', type: dynamodb.AttributeType.STRING },
      deletionProtection: true,
    });

    /** ----------------------------------------
     * Lambda共通環境変数
     ---------------------------------------- */
    const lambdaEnvironmtntCommon = {
      REGION: props!.constant.awsRegion,
      // INGREDIENTS_TABLE_NAME : ingredientTable.tableName, // 最終的にはこちらに変更
      // RECIPES_TABLE_NAME : ingredientTable.tableName, // 最終的にはこちらに変更
      INGREDIENTS_TABLE_NAME : "tbl_ingredients",
      RECIPES_TABLE_NAME : "tbl_recipes",
    };

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
        name: "createRecipeProposal",
        filePath: "../apis/recipes/proposal/src/createRecipeProposal.ts",
        environment: {
          RECIPE_PROPOSAL_PERCENTAGE_THRESHOLD:"20",
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
    const lambdaDynamoRole = new iam.Role(this, 'LambdaDynamoRole', {
      assumedBy: new iam.ServicePrincipal('lambda.amazonaws.com'),
      managedPolicies: [
        iam.ManagedPolicy.fromAwsManagedPolicyName('service-role/AWSLambdaBasicExecutionRole')
      ],
    });

    // TODO:このあたりはDynamoの修正が終わり次第消す
    lambdaDynamoRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("AdministratorAccess")
    );
    lambdaDynamoRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("AWSLambdaExecute")
    );
    lambdaDynamoRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("SecretsManagerReadWrite")
    );
    lambdaDynamoRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("AmazonS3FullAccess")
    );
    lambdaDynamoRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName("AmazonSSMFullAccess")
    );
    lambdaDynamoRole.addManagedPolicy(
      iam.ManagedPolicy.fromAwsManagedPolicyName(
        "service-role/AWSLambdaVPCAccessExecutionRole"
      )
    );

    
    lambdaDynamoRole.addToPolicy(new iam.PolicyStatement({
      effect: iam.Effect.ALLOW,
      actions: ['dynamodb:*'],
      resources: [ingredientTable.tableArn, recipeTable.tableArn],
    }));

    const webSiteBucketPolicyStatement = new iam.PolicyStatement({
      actions: ['s3:GetObject'],
      effect: iam.Effect.ALLOW,
      resources: [`${websiteBucket.bucketArn}/*`],
    });

    websiteBucket.addToResourcePolicy(webSiteBucketPolicyStatement);

    /** ----------------------------------------
     * 
     * Lambda設定
     ---------------------------------------- */
    type lambdaFunctions = {
      [prop: string]: NodejsFunction;
    };
    let lambdaFn: lambdaFunctions = {};
     for (const curLambdaConfig of lambdaConfig) {
      lambdaFn[curLambdaConfig.name] = createNodejsFunction(
        this,
        curLambdaConfig,
        lambdaDynamoRole
      );
     }

    /** ----------------------------------------
     * APIGateway作成
     ---------------------------------------- */

     const api = new aws_apigateway.RestApi(
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
    
    const addCorsToLambdaIntegration = (lambdaFn: lambda.Function) => {
      return new apigateway.LambdaIntegration(lambdaFn, {
        integrationResponses: [{
          statusCode: '200',
          responseParameters: {
            'method.response.header.Access-Control-Allow-Origin': "'*'",
          },
        }],
      });
    };

    const ingredients = api.root.addResource('ingredients')
    ingredients.addMethod('GET', addCorsToLambdaIntegration(lambdaFn.getIngredientList))
    ingredients.addMethod('POST', addCorsToLambdaIntegration(lambdaFn.createIngredient))

    const ingredient = ingredients.addResource('{ingredient_id}')
    ingredient.addMethod('PUT', addCorsToLambdaIntegration(lambdaFn.updateIngredient))
    ingredient.addMethod('DELETE', addCorsToLambdaIntegration(lambdaFn.deleteIngredient))


    const recipes = api.root.addResource('recipes');
    recipes.addMethod('GET', addCorsToLambdaIntegration(lambdaFn.getRecipeList));
    recipes.addMethod('POST', addCorsToLambdaIntegration(lambdaFn.createRecipe));

    const recipe = recipes.addResource('{recipe_id}');
    recipe.addMethod('PUT', addCorsToLambdaIntegration(lambdaFn.updateRecipe));
    recipe.addMethod('DELETE', addCorsToLambdaIntegration(lambdaFn.deleteRecipe));

    const recipeProposal = recipes.addResource('proposal');
    recipeProposal.addMethod('POST', addCorsToLambdaIntegration(lambdaFn.createRecipeProposal));

    const aiRecipeProposal = recipeProposal.addResource('ai-proposal')
    aiRecipeProposal.addMethod('POST', addCorsToLambdaIntegration(lambdaFn.createAiRecipeProposal));


    /** ----------------------------------------
     * S3デプロイ
     ---------------------------------------- */

    new s3_deployment.BucketDeployment(this, 'KondatetyanDeploy', {
      sources: [
        //Flutterアプリのビルドパッケージのパスを指定
        aws_s3_deployment.Source.asset('../../../frontend/kondate_app/build/web'),
      ],
      destinationBucket: websiteBucket,
      distributionPaths: ['/*'],
    });
  }
}
