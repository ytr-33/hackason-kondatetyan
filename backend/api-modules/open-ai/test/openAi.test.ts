import {accessOpenAI} from "../../../apis/recipes/proposal/src/open-ai/openAI"

describe("正常系", ()=>{
    test("テスト駆動",async()=>{
        const result = await accessOpenAI();
        console.log(result.choices[0].message)
    })
})