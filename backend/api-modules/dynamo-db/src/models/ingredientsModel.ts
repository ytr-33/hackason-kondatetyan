import { DynamoDbWrapper } from "../dynamoDbWrapper"
import {Obj} from "@api-modules/util/ObjectUtil"
import { StringUtil } from "@api-modules/util/stringUtil"
import {DynamoDbUtil} from "@api-modules/util/dyanamoDbUtil"

type Ingredient = {
    name?:string;
    category?:string;
    unit?:string;
}

export class IngredientsModel extends DynamoDbWrapper{
    private readonly tableName;
    constructor () {
        super();
        this.tableName = process.env.INGREDIENTS_TABLE_NAME
    }

    /**
     * 現状の食材リストを取得
     * @returns 食材リスト
     */
    public async scanAll ():Promise<any> {
        const scanOutput = await this.dynamoDbClinet.scan({
            TableName: this.tableName
        })

        if (!scanOutput.Items) throw new Error("unexpected Error")

        const items = DynamoDbUtil.convertItemsToObject(scanOutput.Items)
        return items
    }

    /**
     * 新しい食材を作成
     * @param item 食材の詳細
     * @returns 作成した食材ID
     */
    public async createItem(item:Ingredient):Promise<any> {
        // idには現在のUnixTimeを使用
        const curUnixTime = StringUtil.getCurUnixTime()

        let newItem:Obj = {
            id : {N : curUnixTime},
            }
        
        for (const [key, value] of Object.entries(item)) {
            if (value !== undefined) {
                newItem[key] = { S : value } 
            }
        }

        const result = await this.dynamoDbClinet.putItem({
            TableName:this.tableName,
            Item:newItem,
        })

        return curUnixTime
        
    }

    public async UpdateItem(id:number,updateItem:Ingredient):Promise<any>{

        // 更新内容がない場合は終了
        if (Object.keys(updateItem).length === 0 ) return

        const updateScript = DynamoDbUtil.createUpdateScript(updateItem)
        const params = {
            TableName:this.tableName,
            Key :{
                id :{N :String(id)}
            },
            UpdateExpression : updateScript.UpdateExpression,
            ExpressionAttributeNames : updateScript.ExpressionAttributeNames,
            ExpressionAttributeValues: updateScript.ExpressionAttributeValues
        }

        const result = await this.dynamoDbClinet.updateItem(params)
    }

    /**
     * 指定したIDのレコードを削除する
     * @param id 食材ID
     */
    public async DeleteItem(id:number):Promise<any>{
        const result = await this.dynamoDbClinet.deleteItem({
            TableName:this.tableName,
            Key :{
                id :{N :String(id)}
            }
        })
    }

}