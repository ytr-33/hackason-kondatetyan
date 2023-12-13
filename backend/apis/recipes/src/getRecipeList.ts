import { RecipesModel } from "@api-modules/dynamo-db/models/recipesModel";

export const handler = async (event: any) => {
  console.log(JSON.stringify(event))
  const model = new RecipesModel();

  const items = await model.scanAll()

  console.log(items)

  // 成功時のレスポンスを返す
  return {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Headers" : "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*"
  },
    body: JSON.stringify(items),
  };
};

