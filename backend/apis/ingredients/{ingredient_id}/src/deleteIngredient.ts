import { IngredientsModel } from "@api-modules/dynamo-db/models/ingredientsModel";
import {ApiGatewayEventPaser } from "@api-modules/api-gateway";


export const handler = async (event: any) => {
  console.log(JSON.stringify(event))

  const eventParser = new ApiGatewayEventPaser(event)

  const ingredientId = Number(eventParser.getPathParamter("ingredient_id"))

  // TODO：余裕があればバリデーション追加

  const model = new IngredientsModel();

  const items = await model.DeleteItem(ingredientId)

  // 成功時のレスポンスを返す
  return {
    statusCode: 204,
    headers: {
      "Access-Control-Allow-Headers" : "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*"
  },
    body: JSON.stringify(items),
  };
};

