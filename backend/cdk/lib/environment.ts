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
  awsAccount: process.env["AWS_ACCOUNT"]!,
  awsRegion: "ap-northeast-1",
  apigateway: {
    name: "kondatetyan-apigateway",
    usagePlan: "sampleApiUsagePlan",
  },
  apiKey:process.env["OPENAI_API_KEY"]!,
};
