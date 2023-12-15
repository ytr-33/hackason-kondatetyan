import { handler } from "../src/createRecipeProposal";
import { APIGatewayEventMockBuilder} from "@api-modules/test-util";


describe("正常系",()=>{
    test("値の取得",async()=>{
        const event = APIGatewayEventMockBuilder.createAPIGatewayEventMock({
            body : [1646416616464,1701579808]
        })
        const response = await handler(event)

        console.log(response)

        // ハンドラのレスポンスが期待通りの値を含んでいることを確認
        expect(response.statusCode).toBe(200);
    })
});