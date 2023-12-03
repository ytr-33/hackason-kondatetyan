export type Obj = {[key:string]:any}

export class ObjectUtil {

    /**
     * オブジェクトのnull undefinedの項目を削除する
     */
    public static removeUndefinedAndNullProps(object:Obj):Obj {
        return Object.fromEntries(Object.entries(object).filter(([k,v]) => v !== undefined && v !== null));
    }

}