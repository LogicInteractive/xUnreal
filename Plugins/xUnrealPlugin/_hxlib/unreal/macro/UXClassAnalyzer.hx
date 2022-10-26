package unreal.macro;

#if macro

import XUnreal.RetArg;
import haxe.macro.Context;
import haxe.macro.Expr;

class UXClassAnalyzer
{
	static public function checkIfStatic(bf):Bool
	{
		var isStatic:Bool = false;
		var accessList:Array<Dynamic> = bf.access;
		for (ac in accessList)
			if (Std.string(ac)=="AStatic")
				isStatic = true;
		return isStatic;
	}

	static public function constructUFunctionMeta(?isStatic:Null<Bool>,?category:String,superClass:String,metaParams:Array<Dynamic>):String
	{
		var out:String ="";

		var addBPCallable:Bool = false;
		if (superClass=="BlueprintFunctionLibrary")
			addBPCallable = true;

		if (metaParams!=null)
		{
			for (mp in metaParams)
			{
				if (Std.isOfType(mp,String))
				{
					out+='$mp, ';
					if (Std.string(mp).toLowerCase()=="blueprintcallable")
						addBPCallable=false;
				}
				else if (Std.isOfType(mp,Dynamic))
				{
					if (Std.string(mp.identvars)!=null && Std.string(mp.values)!=null)
					{
						if (Std.string(mp.identvars).toLowerCase()=="category")
							category=Std.string(mp.values);
					}
				}
			}
		}

		if (addBPCallable)	
			out+='BlueprintCallable, ';
		if (category!=null && category!="")
			out+='Category = "xUnreal|$category"';
		else
			out+='Category = "xUnreal"';

		return 'UFUNCTION('+out+')';
	}

	static public function extractMetaParams(params:Array<Dynamic>)
	{
		var metaValues:Array<Dynamic> = [];
		for (p in params)
		{
			switch(p.expr)
			{
				case EConst(CIdent(metaIdent)):
				{
					metaValues.push(metaIdent);
				}
				case EBinop(OpAssign, varsExpr, valuesExpr):
				{
					var ident:String = switch(varsExpr.expr)
					{
						case EConst(CIdent(metaIdent)):metaIdent;
						// case EConst(CString(metaStr)):
						// {
						// 	mLine+=metaStr;
						// }
						// case EConst(CString(ident)):
						// {
						// 	metaValues.push(ident);
						// };
						default:"";
					}
					var value:String = switch(valuesExpr.expr)
					{
						case EConst(CString(metaStr)): metaStr;
						default: "";
					}
					metaValues.push({identvars:ident,values:value});
				}
				default:
			}
		}
		return metaValues;
	}

	static public function constructUPropertyMeta(?isStatic:Null<Bool>,?category:String,superClass:String,metaParams:Array<Dynamic>):String
	{
		var out:String ="";

		var addUpropGet:Bool = false;
		var addUpropSet:Bool = false;

		if (metaParams!=null)
		{
			for (mp in metaParams)
			{
				if (Std.isOfType(mp,String))
				{
					out+='$mp, ';
					switch(Std.string(mp).toLowerCase())
					{
						case "editanywhere" :
						{
							addUpropGet = true;	
							addUpropSet = true;	
						}
						case "visibleanywhere" :
						{
							addUpropGet = true;	
						}
						case "blueprintreadwrite" :
						{
							addUpropGet = true;	
							addUpropSet = true;	
						}
						case "blueprintreadonly" :
						{
							addUpropGet = true;	
							addUpropSet = false;	
						}
						// case "blueprintgetter" :
						// case "blueprintsetter" :
						// case "blueprintassignable" :
						// case "blueprintcallable" :
						default:
					}
				}
				else if (Std.isOfType(mp,Dynamic))
				{
					if (Std.string(mp.identvars)!=null && Std.string(mp.values)!=null)
					{
						if (Std.string(mp.identvars).toLowerCase()=="category")
							category=Std.string(mp.values);
					}
				}
			}
		}

		if (addUpropGet)	
			out+='BlueprintGetter={__bpGet__}, ';
		if (addUpropSet)	
			out+='BlueprintSetter={__bpSet__}, ';
		if (category!=null && category!="")
			out+='Category = "xUnreal|$category"';
		else
			out+='Category = "xUnreal"';

		return 'UPROPERTY('+out+')';
	}

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

	static public function getFieldTypePath(f:Dynamic):String
	{
		// if (f==null)
		// 	return null;
			
		// var fv = switch(f.kind)
		// {
		// 	case FVar(f):f;
		// 	default:null;
		// }

		// var fp = switch(fv)
		// {
		// 	case TPath(f):f;
		// 	default:null;
		// }

		// trace(fp);

		// if (fp!=null)
		// 	return fp.name;
		// else
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

}

#end