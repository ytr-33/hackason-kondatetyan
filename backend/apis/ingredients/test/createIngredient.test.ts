import { handler } from "../src/createIngredient";

 describe("正常系",()=>{
    test("新規作成",async()=>{
        const event = ""
        const response = await handler(event)

        console.log(response)

        // ハンドラのレスポンスが期待通りの値を含んでいることを確認
        expect(response.statusCode).toBe(200);
    })
});

