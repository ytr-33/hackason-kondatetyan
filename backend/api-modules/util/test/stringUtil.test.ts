import {StringUtil } from "../src/stringUtil";

describe("UnixTimeの取得",()=>{
    test("正常系",async()=>{
        const curUnixTime = StringUtil.getCurUnixTime();
        console.log(curUnixTime)
    })
});
