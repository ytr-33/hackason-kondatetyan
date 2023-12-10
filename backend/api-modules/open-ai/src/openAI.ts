process.env.OPENAI_API_KEY = "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"
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: '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', // defaults to process.env["OPENAI_API_KEY"]
});

export async function accessOpenAI() {
  const chatCompletion = await openai.chat.completions.create({
    messages: [{ role: 'user', content: 'Say this is a test' }],
    model: 'gpt-3.5-turbo',
  });
  return chatCompletion
}

