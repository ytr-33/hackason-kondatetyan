import * as dotenv from 'dotenv'
dotenv.config()

export interface IStackConst {
  awsAccount: string;
  awsRegion: string;
  apigateway: {
    name: string;
    usagePlan: string;
  };
  apiKey:string;
}

export const stackConst: IStackConst = {
  awsAccount: "930439815160",
  awsRegion: "ap-northeast-1",
  apigateway: {
    name: "kondatetyan-apigateway",
    usagePlan: "sampleApiUsagePlan",
  },
  apiKey:process.env["OPENAI_API_KEY"]!,
};
