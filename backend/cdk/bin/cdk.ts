#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { CdkStack } from "../lib/cdk-stack";
import { stackConst } from "../lib/environment";

const app = new cdk.App();
new CdkStack(app, "CdkStack", {
  constant: stackConst,
  env: {
    account: stackConst.awsAccount,
    region: stackConst.awsRegion,
  },
});
