import { handler } from "../src/getRecipeProposal";
import { APIGatewayEventMockBuilder} from "@api-modules/test-util";


describe("正常系",()=>{
    test("値の取得",async()=>{
        const event = APIGatewayEventMockBuilder.createAPIGatewayEventMock({
            body : [1701954786.822,1701579808]
        })
        const response = await handler(event)

        console.log(response)

        // ハンドラのレスポンスが期待通りの値を含んでいることを確認
        expect(response.statusCode).toBe(200);
    })
});