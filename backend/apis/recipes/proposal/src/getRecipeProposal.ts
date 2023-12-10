import { RecipesModel } from "@api-modules/dynamo-db/models/recipesModel";
import {ApiGatewayEventPaser } from "@api-modules/api-gateway";


export const handler = async (event: any) => {
  console.log(JSON.stringify(event))

  const eventParser = new ApiGatewayEventPaser(event)

  const proposalIdList = eventParser.getParsedBody()

  console.log(proposalIdList)

  const model = new RecipesModel();

  const candidateRecipes = await model.scanAll()

  console.log(candidateRecipes)

  const recipeProposal =   model.createProposal(proposalIdList,candidateRecipes)

  // 成功時のレスポンスを返す
  return {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Headers" : "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*"
  },
    body: JSON.stringify(recipeProposal),
  };
};
