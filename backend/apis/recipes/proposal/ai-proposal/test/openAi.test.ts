import {accessOpenAI} from "../src/open-ai/openAI"

describe("正常系", ()=>{
    test("テスト駆動",async ()=>{
        const ingredients = ["人参","じゃがいも"]
        const result = await accessOpenAI(ingredients);
        console.log(result)
    })
})
