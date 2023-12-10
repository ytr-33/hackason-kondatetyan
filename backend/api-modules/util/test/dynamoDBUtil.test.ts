import {DynamoDbUtil,DynamoObjectList } from "../src/dyanamoDbUtil";

describe("UnixTimeの取得",()=>{
    test("正常系",async()=>{
        const dynamoItems:DynamoObjectList[] = [
            {
              category: { S: 'ss' },
              unit: { S: '個' },
              id: { N: '1701577795.572' },
              name: { S: 'aa' }
            },
            {
              category: { S: 'ss' },
              unit: { S: '個' },
              id: { N: '2' },
              name: { S: 'aa' }
            },
            {
              category: { S: 'ss' },
              id: { N: '1701579808.901' },
              name: { S: 'aa' }
            },
            {
              category: { S: '野菜' },
              unit: { S: '個' },
              id: { N: '0' },
              name: { S: '人参' }
            }
          ]


        const curUnixTime = DynamoDbUtil.convertItemsToObject(dynamoItems);
        console.log(curUnixTime)
    })
});
