import {APIGatewayEvent} from "aws-lambda"

export class ApiGatewayEventPaser {
    constructor(private readonly event:APIGatewayEvent){}

    /**
     * 指定したpathパラメータを取得する
     * @param parameter パラメータ名
     * @returns 値
     */
    public getPathParamter(parameter:string):string | undefined {
        return this.event.pathParameters && this.event.pathParameters[parameter] ? this.event.pathParameters[parameter] : undefined
    }

    public getParsedBody():any {
        const body = this.getBody()
        if (body){
            return JSON.parse(body)
        }
        else{
            return null
        }
    }
    public getBody():string | null {
        return this.event.body
    }
}