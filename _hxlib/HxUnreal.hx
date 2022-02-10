import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type.ClassType;
import haxe.macro.TypeTools;
import sys.FileSystem;
import sys.io.File;

class HxUnreal
{
	static public function buildTemplates(?baseClass:String)
	{
		var mainClass="HxUnrealMain";

		// Context 
		var className =Context.getLocalClass(); 
		var cls:Dynamic = className.get();
		var fields:Array<Dynamic> = Context.getBuildFields();
		// trace("CLASS: "+className);
		// trace("Fields: "+fields);


		// trace(cls.meta.get());//traces the metadata of the class
		// for (field in cls.fields.get())
		// {
		// 	trace(field.meta.get());//traces the metadata of each field
		// }

		// for (f in Reflect.fields(cls))
		// {
		// 	var fi = Reflect.field(cls,f);
		// 	trace(f+" : "+fi.meta);
		// }

		var preFix:String ="";
		var generate:Bool = true;

		var d:Array<Dynamic> = cls.meta.get();
		for (f in d)
		{
			var cMeta:String = f.name;
			if (cMeta==":nogenerate")
				generate = false;
			// if (cMeta==":uprefix")
			// {
			// 	var pList:Array<Dynamic> = f.params;
			// 	for (pm in pList)
			// 	{
			// 		if (pm!=null)
			// 		{
			// 			preFix = switch(pm.expr)
			// 			{
			// 				case EConst(CString(str)):str;
			// 				default:"";
			// 			}
			// 		}
			// 	}
			// }
		}
		
		if (generate)
		{
			var superClass:String = "Actor";
			if (cls.superClass!=null && cls.superClass.t!=null)
			{
				var superClassPath:String = cls.superClass.t.toString();
				superClass = superClassPath.substr(superClassPath.lastIndexOf(".")+1);
			}

			var baseClassStr:String = Std.string(baseClass);
			preFix = baseClassStr.charAt(0);

			var classNameStr:String = Std.string(className);
			var fnOnly:String = classNameStr;
			if (classNameStr.indexOf(".")!=-1)
				fnOnly = classNameStr.substr(classNameStr.lastIndexOf(".")+1);
			
			classNameStr = classNameStr.split(".").join("_");
			var FUclassNameStr = classNameStr.charAt(0).toUpperCase()+classNameStr.substr(1);
			fnOnly = fnOnly.charAt(0).toUpperCase()+fnOnly.substr(1);

			var templateH:String = File.getContent('_hxlib/unreal/templates/$superClass.h.tmp');
			var templateCPP:String = File.getContent('_hxlib/unreal/templates/$superClass.cpp.tmp');

			templateH = StringTools.replace(templateH,"{$hxMainClass}",mainClass);
			templateH = StringTools.replace(templateH,"{className}",fnOnly);
			templateH = StringTools.replace(templateH,"{$superClass}",superClass);
			templateH = StringTools.replace(templateH,"{$prefix}",preFix);
			templateCPP = StringTools.replace(templateCPP,"{$hxMainClass}",mainClass);
			templateCPP = StringTools.replace(templateCPP,"{className}",fnOnly);
			templateCPP = StringTools.replace(templateCPP,"{$prefix}",preFix);

			var exposedMethodsHeader:String = "";
			var exposedMethodsCpp:String = "";

			for (bf in fields)
			{
				var fieldsMeta:Array<Dynamic> = bf.meta;
				for (fm in fieldsMeta)
				{
					var metaName:String = Std.string(fm.name);
					if (metaName==":uexpose" || metaName==":ufunction")// || fm.name==":uproperty")
					{
						var staticaccessor:String = "";
						var isStatic = false;
						if (superClass=="BlueprintFunctionLibrary")
						{
							isStatic = checkIfStatic(bf);
							if (isStatic)
								staticaccessor = "static ";
						}

						var metaParams:Array<Dynamic> = null;
						if (fm.params.length>0)
							metaParams = extractMetaParams(fm.params);

						var hxRtype:String = extractReturnTypeStr(bf);
						var ueRType:String = hxToUEReturnType(hxRtype);

						var category:String = "";
						var uFunction = constructUFunctionMeta(isStatic,category,superClass,metaParams);

						exposedMethodsHeader+='\t$uFunction\n';
						exposedMethodsHeader+='\t$staticaccessor$ueRType ${bf.name}();\n';

						exposedMethodsCpp+='$ueRType $preFix$fnOnly::${bf.name}()\n';
						exposedMethodsCpp+='{\n';
						exposedMethodsCpp+='\treturn '+injectTypeConvert(hxRtype,ueRType)+'($mainClass¤_$fnOnly¤_${bf.name}('+ (isStatic?"":"hxInst") +'));\n';
						exposedMethodsCpp = exposedMethodsCpp.split("¤").join("");
						exposedMethodsCpp+='}\n';
					}
				}
			}

			templateH = StringTools.replace(templateH,"{$exposedMethods}",exposedMethodsHeader);
			templateCPP = StringTools.replace(templateCPP,"{$exposedMethods}",exposedMethodsCpp);


			var folderName = "_hxUnreal";	


			if (!sys.FileSystem.exists('Source/Ue_Hx/_hxUnreal'))
				sys.FileSystem.createDirectory('Source/Ue_Hx/_hxUnreal');
				
			sys.io.File.saveContent('Source/Ue_Hx/_hxUnreal/$fnOnly.h',templateH);
			sys.io.File.saveContent('Source/Ue_Hx/_hxUnreal/$fnOnly.cpp',templateCPP);

		}
		return haxe.macro.Context.getBuildFields();
	}

	static function extractReturnTypeStr(bf):String
	{
		var func = switch(bf.kind)
		{
			case FFun(f):f;
			default:null;
		}						

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

	static function hxToUEReturnType(hxrt:String):String
	{
		return switch(hxrt)
		{
			case "String"		: "FString";
			case "Int"			: "int";
			case "Float"		: "float";
			case "Bool"			: "bool";
			default: "void";
		}
	}

	static function injectTypeConvert(hxType:String,ueType:String):String
	{
		if (hxType=="String")
		{
			return switch(ueType)
			{
				case "FString"		: "_HaxeStringToFString";
				default: "";
			}
		}
		return "";
	}

	static function checkIfStatic(bf):Bool
	{
		var isStatic:Bool = false;
		var accessList:Array<Dynamic> = bf.access;
		for (ac in accessList)
			if (Std.string(ac)=="AStatic")
				isStatic = true;
		return isStatic;
	}

	static function constructUFunctionMeta(?isStatic:Null<Bool>,?category:String,superClass:String,metaParams:Array<Dynamic>):String
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
			out+='Category = "hxUnreal|$category"';
		else
			out+='Category = "hxUnreal"';

		return 'UFUNCTION('+out+')';
	}

	static function extractMetaParams(params:Array<Dynamic>)
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
						case EConst(CIdent(metaIdent)): metaIdent;
						// case EConst(CString(metaStr)):
						// {
						// 	mLine+=metaStr;
						// }
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
}
