package unreal.macro;

#if macro

import XUnreal.RetArg;
import haxe.macro.Context;
import haxe.macro.Expr;

class UXTypeConvert
{
	static public function getFieldTypeName(f:Dynamic):String
	{
		if (f==null)
			return null;
			
		var fv = switch(f.kind)
		{
			case FVar(f):f;
			default:null;
		}
		if (fv==null)
			return null;

		var fp = switch(fv)
		{
			case TPath(f):f;
			default:null;
		}

		if (fp!=null)
			return fp.name;
		else
			return null;
	}

	static public function getFieldGenericFunctionTypes(f:Dynamic):Array<String>
	{
		if (f==null)
			return null;
			
		var fv = switch(f.kind)
		{
			case FVar(f):f;
			default:null;
		}
		if (fv==null)
			return null;

		var fp = switch(fv)
		{
			case TPath(f):f;
			default:null;
		}

		var funcData:Array<String> = [];

		for (tp in fp.params)
		{
			var tpt = switch(tp)
			{
				case TPType(f):f;
				default:null;
			}
			if (tpt!=null)
			{
				var funcParams:Array<Dynamic> = tpt.getParameters();	
				if (funcParams!=null && funcParams.length>1)
				{
					var ftp:Array<Dynamic> = funcParams[0];
					if (ftp!=null)
					{
						for (tftp in ftp)
						{
							var tftptp = switch(tftp)
							{
								case TPath(f):f;
								default:null;
							}
							if (tftptp!=null)
								funcData.push(tftptp.name);
						}
					}
				}		
			}
		}

		return funcData;
	}

	static public function extractUEArgumentsStr(rArgs:Array<RetArg>):String
	{
		var ret = "";
		if (rArgs!=null && rArgs.length>0)
		{
			for (a in rArgs)
			{
				ret+=hxToUEReturnType(a.argType)+" "+a.argName+", ";
			}
			ret = ret.substring(0, ret.length-2);			
		}
		return ret;
	}

	static public function extractUEArgumentsInputStr(rArgs:Array<RetArg>):String
	{
		var ret = "";
		if (rArgs!=null && rArgs.length>0)
		{
			for (a in rArgs)
			{
				ret+=typeConvertHxtoHxStr(a.argType,a.argName)+", ";
			}
			ret = ret.substring(0, ret.length-2);			
		}
		return ret;
	}

	static public function extractInputTypesStr(bf):Array<RetArg>
	{
		var func = switch(bf.kind)
		{
			case FFun(f):f;
			default:null;
		}						

		var rArgs:Array<RetArg> = [];
		if (func!=null && func.args!=null)
		{
			for (a in func.args)
			{
				if (a!=null)
				{
					var ra:RetArg = {argName:null,argType:null};
					if (a.name!=null)
						ra.argName = a.name;
					if (a.type!=null)
					{
						var tp = switch(a.type)
						{
							case TPath(t):t;
							default:null;
						}
						ra.argType = tp.name;			
					}
					rArgs.push(ra);
				}
			}
		}
		return rArgs;
	}
	
	static public function extractReturnTypeStr(bf):String
	{
		var func = switch(bf.kind)
		{
			case FFun(f):f;
			default:null;
		}						

		if (func.ret==null)
			return "";

		var pms:Array<Dynamic> = func.ret.getParameters();
		if (pms!=null)
		{
			for (p in pms)
			{
				if (p!=null)
					return p.name;
			}
		}
		return null;
	}
	
	static public function extractReturnTypeStrProp(bf):String
	{
		var fvar = switch(bf.kind)
		{
			case FVar(f):f;
			default:null;
		}				
		var tp = switch(fvar)
		{
			case TPath(t):t;
			default:null;
		}		
		return tp.name;
	}

	static public function extractValueTypeStr(bf):String
	{
		var variable = switch(bf.kind)
		{
			case FVar(v):v;
			default:null;
		}			

		var pms:Array<Dynamic> = variable.getParameters();
		if (pms!=null)
		{
			for (p in pms)
			{
				if (p!=null)
					return p.name;
			}
		}
		return null;
	}

	static public function hxToUEReturnType(hxrt:String):String
	{
		return switch(hxrt)
		{
			case "Dynamic"		: "FHaxeObject";
			case "String"		: "FString";
			case "Int"			: "int";
			case "Float"		: "float";
			case "Bool"			: "bool";
			case "Vector3"		: "FVector";
			case "Vector2D"		: "FVector2D";
			case "IntArray"		: "TArray<int>";
			case "FloatArray"	: "TArray<double>";
			case "StringArray"	: "TArray<FString>";
			case "Void"			: "void";
			case ""				: "void";
			default: hxrt;
		}
	}

	// static function typeConvertUEtoHxStr(ueType:String,val:String=""):String
	static public function typeConvertHxtoHxStr(ueType:String,val:String=""):String
	{
		var rval = switch(ueType)
		{
			// case "String"		: '_FStringToHaxeString($val)';
			case "String"		: 'TCHAR_TO_UTF8(*$val)';
			case "Vector2D"		: '_UEToHaxeVector2D($val)';
			case "Vector3"		: '_UEToHaxeVector3($val)';
			case "IntArray"		: '_UEToHaxeIntArray($val)';
			case "FloatArray"	: '_UEToHaxeFloatArray($val)';
			case "StringArray"	: '_UEToHaxeStringArray($val)';
			case "Dynamic"		: '_UEToHaxeObject($val)';
			default: val;
		}
		return rval;
	}

	static public function dynamicWrapper(?valName:String,typeName:String=""):String
	{
		if (valName==null)
			return '_UEAnyToHaxeDynamic("","",-1).ref()';

		var typeCode:Int = switch(typeName)
		{
			case "FString"		: 1;
			case "float"		: 2;
			case "int"			: 3;
			case "bool"			: 4;
			case "FHaxeObject"	: 5;
			case _				: 0;
		}
	
		return '_UEAnyToHaxeDynamic(&$valName,"$typeName",$typeCode).ref()';
		// var rval = switch(ueType)
		// {
		// 	// case "String"		: '_FStringToHaxeString($val)';
		// 	case "String"		: 'TCHAR_TO_UTF8(*$val)';
		// 	case "Dynamic"		: '_UEAnyToHaxeDynamic($val)';
		// 	default: val;
		// }
		// return rval;
	}

	static public function injectTypeConvert(hxType:String,ueType:String):String
	{
		if (hxType=="String")
		{
			return switch(ueType)
			{
				case "FString"			: "_HaxeStringToFString";
				default: "";
			}
		}
		else if (hxType=="Vector2D")
		{
			return switch(ueType)
			{
				case "FVector2D"		: "_HaxeVector2DToUE";
				default: "";
			}
		}
		else if (hxType=="Vector3")
		{
			return switch(ueType)
			{
				case "FVector3"			: "_HaxeVector3ToUE";
				default: "";
			}
		}
		else if (hxType=="IntArray")
		{
			return switch(ueType)
			{
				case "TArray<int>"		: "_HaxeIntArrayToUE";
				default: "";
			}
		}
		else if (hxType=="FloatArray")
		{
			return switch(ueType)
			{
				case "TArray<double>"	: "_HaxeFloatArrayToUE";
				default: "";
			}
		}
		else if (hxType=="StringArray")
		{
			return switch(ueType)
			{
				case "TArray<FString>"	: "_HaxeStringArrayToUE";
				default: "";
			}
		}
		else if (hxType=="Dynamic")
		{
			return switch(ueType)
			{
				case "FHaxeObject"		: "_HaxeObjectToUE";
				default: "";
			}
		}
		return "";
	}
}

#end
