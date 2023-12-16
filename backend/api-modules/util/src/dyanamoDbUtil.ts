import { Obj } from "./objectUtil";

export type DynamoObjectList = {
  [key: string]: { [key: string]: any };
};


export class DynamoDbUtil {

    public static convertItemsToObject(items: DynamoObjectList[]): DynamoObjectList[] {
        return items.map((item) => {
          const newItem: Obj = {};
      
          for (const [key, value] of Object.entries(item)) {
            if (value && typeof value === 'object') {
              const subKey = Object.keys(value)[0];
              newItem[key] =
                subKey === 'N' ? parseFloat(value[subKey]) : value[subKey];
            }
          }
      
          return newItem;
        });
      }

      /**
       * DynamoDBアップデート用スクリプトを作成する
       */
      public static createUpdateScript(updateItem:Obj) : {
        UpdateExpression:string;
        ExpressionAttributeNames:Obj;
        ExpressionAttributeValues:Obj;
      } {
        
        // 更新内容の設定文字列の作成
        let UpdateExpression = 'SET';
        let ExpressionAttributeNames:Obj = {}
        let ExpressionAttributeValues:Obj = {}

        for (const [key, value] of Object.entries(updateItem)) {
            if (value){
                UpdateExpression += ` #${key} = :${key},`
                ExpressionAttributeNames[`#${key}`] = `${key}`
                ExpressionAttributeValues[`:${key}`] = { S : value}
            }
        }
        UpdateExpression = UpdateExpression.slice( 0, -1 ) ;

        return {
            UpdateExpression,
            ExpressionAttributeNames,
            ExpressionAttributeValues
        }

      }



}