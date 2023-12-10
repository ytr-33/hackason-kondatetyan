import { DynamoDbWrapper } from "../dynamoDbWrapper"
import {Obj} from "@api-modules/util/ObjectUtil"
import { StringUtil } from "@api-modules/util/stringUtil"
import {DynamoDbUtil,DynamoObjectList} from "@api-modules/util/dyanamoDbUtil"

export type Recipe = {
    id?:number;
    name?:string;
    category?:string;
    ingredients?:string;
    procedure?:string;
}

interface PercentageResult {
    index: number;
    percentage: number;
  }

export class RecipesModel extends DynamoDbWrapper {
    private readonly tableName;
    constructor () {
        super();
        this.tableName = process.env.RECIPES_TABLE_NAME
    }

    /**
     * 現状の料理リストを取得
     * @returns 料理リスト
     */
    public async scanAll ():Promise<Recipe[]> {
        const scanOutput = await this.dynamoDbClinet.scan({
            TableName: this.tableName
        })

        if (!scanOutput.Items) throw new Error("unexpected Error")

        const items = DynamoDbUtil.convertItemsToObject(scanOutput.Items)
        return items as Recipe[]
    }

    

        /**
     * 新しい食材を作成
     * @param item 食材の詳細
     * @returns 作成した食材ID
     */
        public async createItem(item:Recipe):Promise<any> {
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


        public async UpdateItem(id:number,updateItem:Recipe):Promise<any>{

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
     * @param id 料理ID
     */
    public async DeleteItem(id:number):Promise<any>{
        const result = await this.dynamoDbClinet.deleteItem({
            TableName:this.tableName,
            Key :{
                id :{N :String(id)}
            }
        })
    }


    // idを抽出して配列に格納する関数
    public  extractIds(recipes: Recipe[]): number[][] {
    const result: number[][] = [];
  
    if ( !recipes ) throw Error("type error")

    recipes.forEach((recipe) => {
      try {
        if(recipe.ingredients){
            const ingredientsArray = JSON.parse(recipe.ingredients);
        
            if (Array.isArray(ingredientsArray)) {
            const ids = ingredientsArray.map((ingredient: any) => ingredient.id);
            result.push(ids);
            }
        }
      } catch (error) {
        console.error(`Error parsing ingredients for recipe id ${recipe.id}: ${error}`);
      }
    });
  
    return result;
  }

  public createProposal (proposalIdList:number[],candidateRecipes:Recipe[]):Recipe[]{
    const candidateIngredientIdList = this.extractIds(candidateRecipes)

    const result = this.calculateMatchPercentages(candidateIngredientIdList,proposalIdList)
    


    const proposalList = this.filterRecipesByPercentage(candidateRecipes,result)

    console.log(proposalList)
    return proposalList

  }
  
  public calculateMatchPercentages(
    array1: number[][],
    array2: number[]
  ): PercentageResult[] {
    // 結果を格納するための配列
    const result: { index: number; percentage: number }[] = [];
  
    // 各要素ごとに処理
    array1.forEach((subArray, index) => {
      // array2に含まれる要素の数を数える
      const matchingCount = subArray.reduce(
        (count, element) => (array2.includes(element) ? count + 1 : count),
        0
      );
  
      // 一致率を計算
      const percentage = (matchingCount / subArray.length) * 100;
  
      // 結果を配列に追加
      result.push({ index, percentage });
    });
  
    // パーセントが大きい順にソート
    result.sort((a, b) => b.percentage - a.percentage);
  
    // 上位最大5個まで取得
    const topResults = result.slice(0, 5);
  
    return topResults;
  }

  public filterRecipesByPercentage(
    recipes: Recipe[],
    percentageResults: PercentageResult[],
  ): Recipe[] {
    const threshold = 50
    // threshold以上の一致率を持つ結果のindexを取得
    const matchingIndices = percentageResults
      .filter((result) => result.percentage >= threshold)
      .map((result) => result.index);
  
    // 対応するレシピを抽出
    const filteredRecipes = matchingIndices.map((index) => recipes[index]);
  
    return filteredRecipes;
  }

}