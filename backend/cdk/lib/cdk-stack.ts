import { Stack, StackProps, aws_apigateway } from "aws-cdk-lib";
import { Construct } from "constructs";
import { IStackConst } from "./environment";
import * as iam from "aws-cdk-lib/aws-iam";
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb'
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as apigateway from 'aws-cdk-lib/aws-apigateway';
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
     * DynamoDBテーブル　
     ---------------------------------------- */
    const ingredientTable = new dynamodb.Table(this, 'IngredientTable', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.NUMBER },
      sortKey: { name: 'name', type: dynamodb.AttributeType.STRING },
    });

    const recipeTable = new dynamodb.Table(this, 'RecipeTable', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.NUMBER },
      sortKey: { name: 'name', type: dynamodb.AttributeType.STRING },
    });

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
     * IAMロール設定
     ---------------------------------------- */
    const lambdaDynamoRole = new iam.Role(this, 'LambdaDynamoRole', {
      assumedBy: new iam.ServicePrincipal('lambda.amazonaws.com'),
      managedPolicies: [
        iam.ManagedPolicy.fromAwsManagedPolicyName('service-role/AWSLambdaBasicExecutionRole')
      ],
    });

    lambdaDynamoRole.addToPolicy(new iam.PolicyStatement({
      effect: iam.Effect.ALLOW,
      actions: ['dynamodb:*'],
      resources: [ingredientTable.tableArn, recipeTable.tableArn],
    }));

    /** ----------------------------------------
     * Lambda設定
     ---------------------------------------- */
    const getIngredientsLambda = new lambda.Function(this, 'GetIngredientsLambda', {
      runtime: lambda.Runtime.NODEJS_18_X,
      code: lambda.Code.fromAsset('../../apis/ingredients/getIngredients.ts'),
      handler: 'index.handler',
      role: lambdaDynamoRole,
      environment: {
        TABLE_NAME: ingredientTable.tableName,
      },
    });
    
    const getRecipesLambda = new lambda.Function(this, 'GetRecipesLambda', {
      runtime: lambda.Runtime.NODEJS_18_X,
      code: lambda.Code.fromAsset('../../apis/recipes/getRecipes.ts'),
      handler: 'index.handler',
      role: lambdaDynamoRole,
      environment: {
        TABLE_NAME: recipeTable.tableName,
      },
    });

    const postRecipesLambda = new lambda.Function(this, 'PostRecipesLambda', {
      runtime: lambda.Runtime.NODEJS_18_X,
      code: lambda.Code.fromAsset('../../apis/recipes/postRecipes.ts'),
      handler: 'index.handler',
      role: lambdaDynamoRole,
      environment: {
        TABLE_NAME: recipeTable.tableName,
      },
    });

    const putRecipesLambda = new lambda.Function(this, 'PutRecipesLambda', {
      runtime: lambda.Runtime.NODEJS_18_X,
      code: lambda.Code.fromAsset('../../apis/ingredients/putRecipes.ts'),
      handler: 'index.handler',
      role: lambdaDynamoRole,
      environment: {
        TABLE_NAME: recipeTable.tableName,
      },
    });

    const deleteRecipesLambda = new lambda.Function(this, 'deleteRecipesLambda', {
      runtime: lambda.Runtime.NODEJS_18_X,
      code: lambda.Code.fromAsset('../../apis/ingredients/deleteRecipes.ts'),
      handler: 'index.handler',
      role: lambdaDynamoRole,
      environment: {
        TABLE_NAME: recipeTable.tableName,
      },
    });

    const getRecipeProposalLambda = new lambda.Function(this, 'GetRecipeProposalLambda', {
      runtime: lambda.Runtime.NODEJS_18_X,
      code: lambda.Code.fromAsset('../../apis/ingredients/getRecipeProposals.ts'),
      handler: 'index.handler',
      role: lambdaDynamoRole,
      environment: {
        TABLE_NAME: recipeTable.tableName,
      },
    });

    /** ----------------------------------------
     * APIGateway作成
     ---------------------------------------- */
    const api = new apigateway.RestApi(this, 'RecipeApi', {
      restApiName: 'RecipeService',
    });

    api.root.addResource('ingredients').addMethod('GET', new apigateway.LambdaIntegration(getIngredientsLambda));

    const recipes = api.root.addResource('recipes');
    recipes.addMethod('GET', new apigateway.LambdaIntegration(getRecipesLambda));
    recipes.addMethod('POST', new apigateway.LambdaIntegration(postRecipesLambda));

    const recipe = recipes.addResource('{recipe_id}');
    recipe.addMethod('PUT', new apigateway.LambdaIntegration(putRecipesLambda));
    recipe.addMethod('DELETE', new apigateway.LambdaIntegration(deleteRecipesLambda));

    recipes.addResource('proposal').addMethod('GET', new apigateway.LambdaIntegration(getRecipeProposalLambda));
  
    const usagePlan = api.addUsagePlan(props!.constant.apigateway.usagePlan);
    usagePlan.addApiStage({ stage: api.deploymentStage });
  }
}
