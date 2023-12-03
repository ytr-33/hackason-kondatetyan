import { IngredientsModel } from "@api-modules/dynamo-db/models/ingredientsModel";
import {ApiGatewayEventPaser } from "@api-modules/api-gateway";

export const handler = async (event: any) => {
  console.log(JSON.stringify(event))

  const eventParser = new ApiGatewayEventPaser(event)

  const ingredientId = Number(eventParser.getPathParamter("ingredient_id"))
  const body = eventParser.getParsedBody() as {[key:string]:string}

  // TODO：余裕があればバリデーション追加

  const model = new IngredientsModel();

  const items = await model.UpdateItem(ingredientId,body)

  // 成功時のレスポンスを返す
  return {
    statusCode: 200,
    body: JSON.stringify(items),

  };
};

