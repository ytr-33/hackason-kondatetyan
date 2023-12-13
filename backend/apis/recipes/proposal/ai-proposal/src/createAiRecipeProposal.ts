import {ApiGatewayEventPaser } from "@api-modules/api-gateway";
import { accessOpenAI } from "./open-ai/openAI";
import { IngredientsModel } from "@api-modules/dynamo-db/models/ingredientsModel";
export const handler = async (event: any) => {
  console.log(JSON.stringify(event))

  const eventParser = new ApiGatewayEventPaser(event)

  const proposalIdList = eventParser.getParsedBody()
  console.log(proposalIdList)
 
  const ingredientModel = new IngredientsModel(); 

  const ingredients = await ingredientModel.getNamesFromIds(proposalIdList)

  console.log(ingredients)

  const recipeProposal =   await accessOpenAI(ingredients)
  
  // 成功時のレスポンスを返す
  return {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Headers" : "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*"
  },
    body: recipeProposal,
  };
};
