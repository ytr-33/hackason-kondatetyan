import { DynamoDB } from "@aws-sdk/client-dynamodb";

export class DynamoDbWrapper {
    protected readonly dynamoDbClinet: DynamoDB;
    constructor(){
        this.dynamoDbClinet = new DynamoDB({});
    }



}