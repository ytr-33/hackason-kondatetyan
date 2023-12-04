import { IngredientsModel } from "@api-modules/dynamo-db/models/ingredientsModel";

export const handler = async (event: any) => {
  console.log(JSON.stringify(event))
  const model = new IngredientsModel();

  const items = await model.scanAll()

  console.log(items)

  // 成功時のレスポンスを返す
  return {
    statusCode: 200,
    body: JSON.stringify(items),
  };
};

