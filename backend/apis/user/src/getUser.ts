import { DynamoDBClient, ScanCommand } from "@aws-sdk/client-dynamodb";

/**
 * Lambdaが実行されるとhandler関数が実行される
 * @param
 * event : lambdaに渡される引数
 */
export const handler = async (event: any) => {

  // テーブル名を指定
  const tableName = "tbl_serverlessAPP_20230909";

  const items = await NameDao.getName(tableName);
  
  // 成功時のレスポンスを返す
  return {
    statusCode: 200,
    body: JSON.stringify(items),
  };
};

export class NameDao {
  static getName = async (tableName:string):Promise<any> => {

  // DynamoDBクライアントインスタンス作成
  const dynamoDBClient = new DynamoDBClient();

  // Scanコマンドを作成
  const scanCommand = new ScanCommand({
    TableName: tableName,
  });

  //DynamoDBからデータを取得
  const data = await dynamoDBClient.send(scanCommand);

  // スキャン結果のアイテムを取得
  const items = data.Items;

  return items
}
}
