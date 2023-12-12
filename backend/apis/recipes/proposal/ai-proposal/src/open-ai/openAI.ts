
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey:process.env["OPENAI_API_KEY"] 
});

export const accessOpenAI = async (ingredients:string[]):Promise<any> => {
  console.log(ingredients)
  let content = `次の候補食材を使って作成できる料理とその調理方法を提案してください.\n 候補食材：`
  for(const ingredient of ingredients){
    content += ingredient + ", "
  }
  console.log(content)
  const chatCompletion = await openai.chat.completions.create({
    messages: [{ role: 'user', content }],
    model: 'gpt-3.5-turbo',
  });

  const chatResponse = chatCompletion.choices[0].message.content

  return chatResponse
}

