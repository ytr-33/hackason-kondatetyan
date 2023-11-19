import { NodejsFunction } from "aws-cdk-lib/aws-lambda-nodejs";
import { Role } from "aws-cdk-lib/aws-iam";
import { Construct } from "constructs";
import { Duration, Tags } from "aws-cdk-lib";
import { Runtime } from "aws-cdk-lib/aws-lambda";

export interface LambdaConfig {
  name: string;
  filePath: string;
  environment: {
    [envName: string]: string;
  };
}

export const createNodejsFunction = (
  construct: Construct,
  lambdaConfig: LambdaConfig,
  role: Role
): NodejsFunction => {
  const lambdaFunction = new NodejsFunction(construct, lambdaConfig.name, {
    functionName: lambdaConfig.name,
    entry: lambdaConfig.filePath,
    environment: lambdaConfig.environment,
    bundling: {
      sourceMap: true,
    },
    timeout: Duration.seconds(28),
    memorySize: 1024,
    runtime: Runtime.NODEJS_18_X,
    role: role,
  });
  return lambdaFunction;
};
