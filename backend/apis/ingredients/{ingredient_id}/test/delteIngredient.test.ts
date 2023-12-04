import { handler } from "../src/deleteIngredient";

 describe("正常系",()=>{
    test("data削除",async()=>{
        const event = ""
        const response = await handler(event)

        console.log(response)

        // ハンドラのレスポンスが期待通りの値を含んでいることを確認
        expect(response.statusCode).toBe(200);
    })
});