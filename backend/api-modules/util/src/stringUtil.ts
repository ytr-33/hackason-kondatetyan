export class StringUtil {

    /**
     * 現在のUnixTimeを取得(13桁)
     */
    public static getCurUnixTime () : string {
        const curUnixTime =String( new Date().getTime()/1000)
        return curUnixTime
    }

}