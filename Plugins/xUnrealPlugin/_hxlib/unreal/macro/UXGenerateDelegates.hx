package unreal.macro;

#if macro

import XUnreal.RetArg;

class UXGenerateDelegates
{
	static public function generateDelegates(bf:Dynamic,modulePath:String,delegateNumber:Int,superClass:String)
	{
		var fieldName:String = bf.name;
		var baseDelegateStr:String = "DECLARE_DYNAMIC_MULTICAST_DELEGATE";
		var accessTypes:String = "BlueprintAssignable,BlueprintCallable";
		var delegatesTop:String="";
		var delegatesFields:String="";
		var delegateBinds:String="";
		var delegateUnbinds:String="";
		var delegateActions:String="";
		var delegateDefinitions:String="";
		var dName:String = modulePath;
		var delType:String = "FXUDynamicType";
		// UXClassAnalyzer.getFieldTypePath(bf);
		var n = UXTypeConvert.getFieldTypeName(bf);
		if (n=="DynamicMulticastDelegate")
		{
			var hxAtype:Array<RetArg> = UXTypeConvert.extractInputTypesStr(bf);							
			var funcTypes = UXTypeConvert.getFieldGenericFunctionTypes(bf);
			if (funcTypes.length>0)
			{
				var fLen:Int = funcTypes.length;
				if (fLen==1)
				{	
					delegateNumber++;
					var fn:String = 'FD${dName}Event$delegateNumber';			
					var uet1:String = UXTypeConvert.hxToUEReturnType(funcTypes[0]);			
					// delegatesTop+='${baseDelegateStr}_OneParam($fn, $uet1, ${funcTypes[0]});\n';
					delegatesTop+='${baseDelegateStr}_OneParam($fn, $delType, param1);\n';

					delegatesFields+='\tUPROPERTY($accessTypes)\n';
					delegatesFields+='\t$fn $fieldName;\n';
					// delegateActions+='void '+"{$prefix}{className}"+'::On${fn}($uet1 ${funcTypes[0]})\n';				
					delegateActions+='void '+"{$prefix}{className}"+'::On${fn}($delType param1)\n';				
					delegateActions+='{\n';	
					delegateActions+='\tif (GEngine!=NULL && haxeRunning && hxInst)\n';				
					// delegateActions+='\t\tXUnrealMain_unreal_${superClass}_incomingDelegate(hxInst,"${fieldName}",$fLen,${UXTypeConvert.dynamicWrapper(funcTypes[0],uet1)},NULL,NULL);\n';				
					delegateActions+='\t\tXUnrealMain_unreal_${superClass}_incomingDelegate(hxInst,"${fieldName}",$fLen,&param1.dynamic,NULL,NULL);\n';				
					delegateActions+='}\n';
					// delegateDefinitions+='\tUFUNCTION()\n\tvoid On${fn}($uet1 ${funcTypes[0]});\n';		
					delegateDefinitions+='\tUFUNCTION()\n\tvoid On${fn}($delType param1);\n';		
				}					
				else if (funcTypes.length==2)
				{	
					delegateNumber++;
					var fn:String = 'FD${dName}Event$delegateNumber';			
					var uet1:String = UXTypeConvert.hxToUEReturnType(funcTypes[0]);			
					var uet2:String = UXTypeConvert.hxToUEReturnType(funcTypes[1]);			
					// delegatesTop+='${baseDelegateStr}_TwoParams($fn, $uet1, ${funcTypes[0]}, $uet2, ${funcTypes[1]});\n';
					delegatesTop+='${baseDelegateStr}_TwoParams($fn, $delType, param1, $delType, param2);\n';

					delegatesFields+='\tUPROPERTY($accessTypes)\n';
					delegatesFields+='\t$fn $fieldName;\n';
					// delegateActions+='void '+"{$prefix}{className}"+'::On${fn}($uet1 ${funcTypes[0]},$uet2 ${funcTypes[1]})\n';				
					delegateActions+='void '+"{$prefix}{className}"+'::On${fn}($delType param1, $delType param2)\n';				
					delegateActions+='{\n';				
					delegateActions+='\tif (GEngine!=NULL && haxeRunning && hxInst)\n';				
					// delegateActions+='\t\tXUnrealMain_unreal_${superClass}_incomingDelegate(hxInst,"${fieldName}",$fLen,${UXTypeConvert.dynamicWrapper(funcTypes[0],uet1)},${UXTypeConvert.dynamicWrapper(funcTypes[1],uet2)},NULL);\n';				
					delegateActions+='\t\tXUnrealMain_unreal_${superClass}_incomingDelegate(hxInst,"${fieldName}",$fLen,&param1.dynamic,&param2.dynamic,NULL);\n';				
					delegateActions+='}\n';	
					// delegateDefinitions+='\tUFUNCTION()\n\tvoid On${fn}($uet1 ${funcTypes[0]},$uet2 ${funcTypes[1]});\n';		
					delegateDefinitions+='\tUFUNCTION()\n\tvoid On${fn}($delType param1, $delType param2);\n';		
				}					
				else if (funcTypes.length==3)
				{	
					delegateNumber++;
					var fn:String = 'FD${dName}Event$delegateNumber';			
					var uet1:String = UXTypeConvert.hxToUEReturnType(funcTypes[0]);			
					var uet2:String = UXTypeConvert.hxToUEReturnType(funcTypes[1]);			
					var uet3:String = UXTypeConvert.hxToUEReturnType(funcTypes[2]);			
					// delegatesTop+='${baseDelegateStr}_ThreeParams($fn, $uet1, ${funcTypes[0]}, $uet2, ${funcTypes[1]}, $uet3, ${funcTypes[2]});\n';
					delegatesTop+='${baseDelegateStr}_ThreeParams($fn, $delType, param1, $delType, param2, $delType, param3);\n';

					delegatesFields+='\tUPROPERTY($accessTypes)\n';
					delegatesFields+='\t$fn $fieldName;\n';
					// delegateActions+='void '+"{$prefix}{className}"+'::On${fn}($uet1 ${funcTypes[0]},$uet2 ${funcTypes[1]},$uet3 ${funcTypes[2]})\n';				
					delegateActions+='void '+"{$prefix}{className}"+'::On${fn}($delType param1, $delType param2, $delType param3)\n';				
					delegateActions+='{\n';				
					delegateActions+='\tif (GEngine!=NULL && haxeRunning && hxInst)\n';				
					// delegateActions+='\t\tXUnrealMain_unreal_${superClass}_incomingDelegate(hxInst,"${fieldName}",$fLen,${UXTypeConvert.dynamicWrapper(funcTypes[0],uet1)},${UXTypeConvert.dynamicWrapper(funcTypes[1],uet2)},${UXTypeConvert.dynamicWrapper(funcTypes[2],uet3)});\n';				
					delegateActions+='\t\tXUnrealMain_unreal_${superClass}_incomingDelegate(hxInst,"${fieldName}",$fLen,&param1.dynamic,&param2.dynamic,&param3.dynamic);\n';				
					delegateActions+='}\n';				
					// delegateDefinitions+='\tUFUNCTION()\n\tvoid On${fn}($uet1 ${funcTypes[0]},$uet2 ${funcTypes[1]},$uet3 ${funcTypes[2]});\n';		
					delegateDefinitions+='\tUFUNCTION()\n\tvoid On${fn}($delType param1, $delType param2, $delType param3);\n';		
				}					
/* 				else if (funcTypes.length==4)
				{	
					delegateNumber++;
					var fn:String = 'FXUDelegate$delegateNumber';			
					var uet1:String = hxToUEReturnType(funcTypes[0]);			
					var uet2:String = hxToUEReturnType(funcTypes[1]);			
					var uet3:String = hxToUEReturnType(funcTypes[2]);			
					var uet4:String = hxToUEReturnType(funcTypes[3]);			
					delegatesTop+='${baseDelegateStr}_ThreeParams($fn, $uet1, ${funcTypes[0]}, $uet2, ${funcTypes[1]}, $uet3, ${funcTypes[2]}, $uet4, ${funcTypes[3]});\n';

					delegatesFields+='\tUPROPERTY($accessTypes)\n';
					delegatesFields+='\t$fn $fieldName;\n';
					delegateActions+='void '+"{$prefix}{className}"+'::On${fieldName}Event($uet1 ${funcTypes[0]}, $uet2 ${funcTypes[1]}, $uet3 ${funcTypes[2]}, $uet4 ${funcTypes[3]})\n';				
					delegateActions+='{\n';				
					// delegateActions+='\tif (GEngine!=NULL && haxeRunning && hxInst)\n';				
					// delegateActions+='\t\tXUnrealMain_unreal_Object_incomingDelegate(hxInst,"${fieldName}",$fLen,${typeConvertHxtoHxStr(funcTypes[0],funcTypes[0])},${typeConvertHxtoHxStr(funcTypes[1],funcTypes[1])},${typeConvertHxtoHxStr(funcTypes[2],funcTypes[2])},${typeConvertHxtoHxStr(funcTypes[3],funcTypes[3])},NULL);\n';				
					delegateActions+='}\n';				
					delegateDefinitions+='\tUFUNCTION()\n\tvoid On${fieldName}Event($uet1 ${funcTypes[0]}, $uet2 ${funcTypes[1]}, $uet3 ${funcTypes[2]}, $uet4 ${funcTypes[3]});\n';	
				}					
				else if (funcTypes.length==5)
				{	
					delegateNumber++;
					var fn:String = 'FXUDelegate$delegateNumber';			
					var uet1:String = hxToUEReturnType(funcTypes[0]);			
					var uet2:String = hxToUEReturnType(funcTypes[1]);			
					var uet3:String = hxToUEReturnType(funcTypes[2]);			
					var uet4:String = hxToUEReturnType(funcTypes[3]);			
					var uet5:String = hxToUEReturnType(funcTypes[4]);			
					delegatesTop+='${baseDelegateStr}_ThreeParams($fn, $uet1, ${funcTypes[0]}, $uet2, ${funcTypes[1]}, $uet3, ${funcTypes[2]}, $uet4, ${funcTypes[3]}), $uet5, ${funcTypes[4]});\n';

					delegatesFields+='\tUPROPERTY($accessTypes)\n';
					delegatesFields+='\t$fn $fieldName;\n';
					delegateActions+='void '+"{$prefix}{className}"+'::On${fieldName}Event($uet1 ${funcTypes[0]}, $uet2 ${funcTypes[1]}, $uet3 ${funcTypes[2]}, $uet4 ${funcTypes[3]}, $uet5 ${funcTypes[4]})\n';				
					delegateActions+='{\n';				
					// delegateActions+='\tif (GEngine!=NULL && haxeRunning && hxInst)\n';				
					// delegateActions+='\t\tXUnrealMain_unreal_Object_incomingDelegate(hxInst,"${fieldName}",$fLen,${typeConvertHxtoHxStr(funcTypes[0],funcTypes[0])},${typeConvertHxtoHxStr(funcTypes[1],funcTypes[1])},${typeConvertHxtoHxStr(funcTypes[2],funcTypes[2])},${typeConvertHxtoHxStr(funcTypes[3],funcTypes[3])},${typeConvertHxtoHxStr(funcTypes[3],funcTypes[3])});\n';				
					delegateActions+='}\n';				
					delegateDefinitions+='\tvoid On${fieldName}Event($uet1 ${funcTypes[0]}, $uet2 ${funcTypes[1]}, $uet3 ${funcTypes[2]}, $uet4 ${funcTypes[3]}, $uet5 ${funcTypes[4]});\n';	
				}					
 */				var fn:String = 'FD${dName}Event$delegateNumber';
				delegateBinds+='\t$fieldName.AddDynamic(this, &'+"{$prefix}{className}"+'::On${fn});\n';				
				delegateUnbinds+='\t$fieldName.RemoveDynamic(this, &'+"{$prefix}{className}"+'::On${fn});\n';				
			}
		}
		
		return 
		{
			delegateNumber:delegateNumber,
			deledelegatesTop:delegatesTop,
			delegatesFields:delegatesFields,
			delegateBinds:delegateBinds,
			delegateUnbinds:delegateUnbinds,
			delegateActions:delegateActions,
			delegateDefinitions:delegateDefinitions
		};
	}				
}

#end