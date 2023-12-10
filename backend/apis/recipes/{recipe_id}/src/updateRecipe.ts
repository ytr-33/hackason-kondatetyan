import { RecipesModel } from "@api-modules/dynamo-db/models/recipesModel";
import {ApiGatewayEventPaser } from "@api-modules/api-gateway";

export const handler = async (event: any) => {
  console.log(JSON.stringify(event))

  const eventParser = new ApiGatewayEventPaser(event)

  const id = Number(eventParser.getPathParamter("recipe_id"))
  const body = eventParser.getParsedBody() as {[key:string]:string}

  // TODO：余裕があればバリデーション追加

  const model = new RecipesModel();

  const items = await model.UpdateItem(id,body)

  // 成功時のレスポンスを返す
  return {
    statusCode: 201,
    headers: {
      "Access-Control-Allow-Headers" : "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*"
  },
    body: JSON.stringify(items),

  };
};

