import { APIGatewayProxyEventPathParameters,APIGatewayEvent } from "aws-lambda"

export type APIGatewayEventParams = {
    pathParameter? : APIGatewayProxyEventPathParameters;
    body? :any
}

export class APIGatewayEventMockBuilder {
    constructor(){}

    public static createAPIGatewayEventMock (param:APIGatewayEventParams ):APIGatewayEvent {
        const pathParameter = param.pathParameter ?? null;
        const body = param.body ? JSON.stringify(param.body) : null;
        return {
            "resource": "/apis/ingredients",
            "path": "/apis/ingredients",
            "httpMethod": "POST",
            "headers": {},
            "multiValueHeaders": {},
            "queryStringParameters": null,
            "multiValueQueryStringParameters": null,
            "pathParameters": pathParameter,
            "stageVariables": null,
            "requestContext": {
                "authorizer":undefined,
                "resourceId": "wtlnoc",
                "resourcePath": "/apis/ingredients",
                "httpMethod": "POST",
                "extendedRequestId": "PWyAWFaTNjMFSTA=",
                "requestTime": "03/Dec/2023:07:38:16 +0000",
                "path": "/apis/ingredients",
                "accountId": "930439815160",
                "protocol": "HTTP/1.1",
                "stage": "test-invoke-stage",
                "domainPrefix": "testPrefix",
                "requestTimeEpoch": 1701589096359,
                "requestId": "16b1725d-79af-48a3-8682-94eef06eb17c",
                "identity": {
                    "cognitoIdentityPoolId": null,
                    "cognitoIdentityId": null,
                    "apiKey": "test-invoke-api-key",
                    "principalOrgId": null,
                    "cognitoAuthenticationType": null,
                    "userArn": "arn:aws:iam::930439815160:user/morita",
                    "apiKeyId": "test-invoke-api-key-id",
                    "userAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0",
                    "accountId": "930439815160",
                    "caller": "AIDA5RIUI374IUYTE3L6O",
                    "sourceIp": "test-invoke-source-ip",
                    "accessKey": "ASIA5RIUI374DO7BXOOW",
                    "cognitoAuthenticationProvider": null,
                    "user": "AIDA5RIUI374IUYTE3L6O",
                    "clientCert":null
                },
                "domainName": "testPrefix.testDomainName",
                "apiId": "x3mh57lyz4"
            },
            "body": body,
            "isBase64Encoded": false
        }
    }
}