export interface IStackConst {
  awsAccount: string;
  awsRegion: string;
  apigateway: {
    name: string;
    usagePlan: string;
  };
}

export const stackConst: IStackConst = {
  awsAccount: "930439815160",
  awsRegion: "ap-northeast-1",
  apigateway: {
    name: "hackason-kondatetyan",
    usagePlan: "sampleApiUsagePlan",
  },
};
