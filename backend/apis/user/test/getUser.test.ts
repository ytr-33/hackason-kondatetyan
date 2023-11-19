import { handler, NameDao } from "../src/getUser";

// getNameメソッドをモックする
jest.spyOn(NameDao, 'getName').mockImplementation(async(tableName: string) => {
  return [{ 
    id: 2,
    name: "jiro"
  }];
});
/**--------------------------------------
 * テスト実施
 --------------------------------------*/

 describe("正常系",()=>{
    test("値の取得",async()=>{
        const event = ""
        const response = await handler(event)

        console.log(response)

        // ハンドラのレスポンスが期待通りの値を含んでいることを確認
        expect(response.statusCode).toBe(200);
        expect(JSON.parse(response.body)).toEqual([{
        id: 2,
        name: "jiro"
        }]);

    })
});