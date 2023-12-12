process.env.OPENAI_API_KEY = "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"
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: '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', // defaults to process.env["OPENAI_API_KEY"]
});




export const accessOpenAI = async (ingredients:string[],recipes:string[]):Promise<any> => {
  // const ingredients = ["人参","じゃがいも"]
  // const recipes = ["カレー","シチュー","ホットサンド"]
  const content = `候補食材を使って作成できるレシピを最大5つ候補レシピの中から提案してください.\n`
  + `候補食材：\'${ingredients[0]}\', \'${ingredients[1]}\' \n` 
  + `候補レシピ：\'${recipes[0]}\',\'${recipes[1]}\',\'${recipes[2]}\' \n `
  + "回答形式は次のようなJSON形式にしてください。{\"提案レシピ\":[\"レシピ名\",...]} \n"
  // + "また、提案するレシピは必ず候補レシピの中から選んでください。"
  
  console.log(content)
  const chatCompletion = await openai.chat.completions.create({
    messages: [{ role: 'user', content }],
    model: 'gpt-3.5-turbo',
  });

  

  return chatCompletion
}

