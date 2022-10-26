package lib.utils;

import haxe.PosInfos;

class PosInfosUtils
{
    public static function toString( posInfos : PosInfos ) : String
	{
        if ( posInfos != null )
            return posInfos.className + "." + posInfos.methodName + "() at " + posInfos.fileName + ":" + posInfos.lineNumber;

        return "";
    }

    public static function toStringClassLine( posInfos : PosInfos ) : String
	{
        if ( posInfos != null )
            return posInfos.className + ":" + posInfos.lineNumber;

        return "";
    }

    public static function toStringClassMethodLine( posInfos : PosInfos ) : String
	{
        if ( posInfos != null )
            return posInfos.className + "." + posInfos.methodName + "():" + posInfos.lineNumber;

        return "";
    }
}