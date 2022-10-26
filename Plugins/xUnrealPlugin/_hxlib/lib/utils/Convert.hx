package lib.utils;

import lib.utils.StringUtils;

/**
 * ...
 * @author Tommy S.
 */
class Convert
{

	public static function toBool( value:Dynamic ):Bool
	{
		var isBoolean:Bool = false;
		var strVal:String = Std.string(value);
			
		switch ( strVal.toLowerCase() )
		{
			case "1":
				isBoolean = true;
			case "true":
				isBoolean = true;
			case "yes":
				isBoolean = true;
			case "y":
				isBoolean = true;
			case "on":
				isBoolean = true;
			case "enabled":
				isBoolean = true;
		}

		return isBoolean;
	}
/*	
	public static function toUint( value:* ):uint
	{
		return uint(value);
	}
*/	
	public static function toString( value:Any ):String
	{
		if (value == null)
			return "";
			
		if (Std.isOfType(value, String))
		{
			var valStr:String = cast value;
			if (StringUtils.contains(valStr,"%"))
			{
				var ta = valStr.split("%");
				if (ta!=null)
					return Std.string(ta[0]);
				else
					return "";
			}
			else
			{
				return Std.string(value);
			}
		}
		else
		{
			return Std.string(value);
		}
	}	
	
	public static function toInt( value:Dynamic ):Int
	{
		if (value == null)
			return -1;
			
		if (Std.isOfType(value, Int))
		{
			if (StringUtils.contains(value,"%"))
			{
				var ta = value.split("%");
				if (ta!=null)
					return Std.parseInt(ta[0]);
				else
					return -1;
			}
			else
			{
				return Std.parseInt(value);
			}
		}
		else
		{
			return Std.parseInt(value);
		}
	}		
	
	public static function toUInt( value:Dynamic ):UInt
	{
		if (value == null)
			return 0;
			
/*		if (Std.isOfType(value, UInt))
		{
			if (StringUtils.contains(value,"%"))
			{
				var ta = value.split("%");
				if (ta!=null)
					return cast(ta[0],UInt);
				else
					return -1;
			}
			else
			{
				return cast(value,UInt);
			}
		}
		else
		{*/
			return cast(value,UInt);
		//}
	}	
	
	public static function toFloat( value:Dynamic, ?percentOfValue:Null<Float> ):Float
	{
		if (value == null)
			return 0;
			
		if (Std.isOfType(value, String))
		{
			if (StringUtils.contains(value,"%"))
			{
				var ta = value.split("%");
				if (ta != null)
				{
					if (percentOfValue != null)
					{
						return Std.parseFloat(Std.string(ta[0]*percentOfValue*0.01));
					}
					else
						return Std.parseFloat(Std.string(ta[0]));
				}
				else
					return 0;
			}
			else
			{
				return Std.parseFloat(value);
			}
		}
		else
		{
			return Std.parseFloat(Std.string(value));
		}
		/*
		if ((String(value).indexOf("f")==-1) && (String(value).indexOf("e")==-1) && (String(value).indexOf("d")==-1) && (String(value).indexOf("c")==-1) && (String(value).indexOf("b")==-1) && (String(value).indexOf("a")==-1))
			return Number(value)
		else if (String(value).indexOf("0x")==-1)
		{
			return Number(uint("0x"+value))
		}
		else
		{
			return Number(uint(value))
		}
		*/
	}
	
/*
	public static function toVector3D( value:* ):Vector3D
	{
		var rvec:Vector3D = new Vector3D();
		if (value is String)
		{
			value = toArray(value)
		}
		if ((value is XMLList) || (value is XML))
		{
			value=toArray(String(value));
		}
		
		if (value is Array)
		{
			if ((value as Array).length > 0) rvec.x = toNumber(value[0])
			if ((value as Array).length > 1) rvec.y = toNumber(value[1])
			if ((value as Array).length > 2) rvec.z = toNumber(value[2])
			if ((value as Array).length > 3) rvec.w = toNumber(value[3])
		}
		
		return rvec;
	}
	
	public static function toVector4( value1:*=null, value2:*=null, value3:*=null, value4:*=null ):Vector.<Number>
	{
		var ret:Vector.<Number>=Vector.<Number>([0,0,0,0]);

		if (value1)
		{
			if (value1 is String)
				value1 = toNumber(value1)
			if (value1 is Number)
				ret[0]=value1;
		}
		if (value2)
		{
			if (value2 is String)
				value2 = toNumber(value2)
			if (value2 is Number)
				ret[1]=value2;
		}
		if (value3)
		{
			if (value3 is String)
				value3 = toNumber(value3)
			if (value3 is Number)
				ret[2]=value3;
		}
		if (value4)
		{
			if (value4 is String)
				value4 = toNumber(value4)
			if (value4 is Number)
				ret[3]=value4;
		}
		
		return ret;
	}		
	
	static private function generic(value:*):* 
	{
		var nval:*;
		return nval;
	}
	
	public static function toArray( value:* ):Array
	{
		var retArr:Array = new Array();
		
		if (value is String)
		{
			if (String(value).indexOf("0x") !== -1)
			{
				value = hexToObject(value).arraystring;
			}
			
			var ast:int = String(value).indexOf("[");
			var aen:int = String(value).indexOf("]");
			if (ast !== -1 && aen !== -1)
			{
				retArr = String(value).substr(ast+1, aen-1).split(",");
			}
			else
				retArr = String(value).split(",");
		}
		
		return retArr;
	}
	
	static private function hexToObject(value:*):Object 
	{
		var retObj:Object = new Object();
		if (value is String)
		{
			var itA:Array = String(value).split("");
			retObj.r = toInt(String(itA[2]) + String(itA[3]));
			retObj.g = toInt(String(itA[4]) + String(itA[5]));
			retObj.b = toInt(String(itA[6]) + String(itA[7]));
			retObj.hex = toInt(String(itA[2]) + String(itA[3]) + String(itA[4]) + String(itA[5]) + String(itA[6]) + String(itA[7]));
			retObj.arraystring = String(String(itA[2]) + String(itA[3]) +","+ String(itA[4]) + String(itA[5]) +","+ String(itA[6]) + String(itA[7]));
			retObj.org = value;
		}
		
		return retObj;
	}
	
	public static function prosent($prosent:String,$orgverdi:Number):*
	{
		if ($prosent.indexOf("%") !== -1)
		{
			var vnp:Number = Number($prosent.split("%")[0]);
			return $orgverdi * (vnp * 0.01);
		}
		else
			return null;
	}
	
	public static function toDegrees(radians:Number):Number
	{
		return radians * 180 / Math.PI;
	}

	//	Degrees to radians	
	public static function toRadians(degrees:Number):Number
	{
		return degrees * Math.PI / 180;
	}		
*/	
}

