#pragma once

#include "../Binaries/haxe_build/xUnrealMain.h"
#include "HaxeObject.h"
#include <../_hxlib/unreal/types/DynamicWrapper.h>
#include "XUDynamicType.generated.h"

USTRUCT(BlueprintType)
struct FXUDynamicType
{
    GENERATED_BODY()
    FXUDynamicType() {}
	DynamicWrapper dynamic;

public:
	void setString(const char* str)
	{
		// dynamic.v_type = "FString";
		dynamic.v_typeCode = 4;
		dynamic.v_str = str;
	}
};

/* 
DynamicWrapper inline _UEAnyToHaxeDynamic(void* val, const char* type, int typeCode)
{
	DynamicWrapper dynamic;
	dynamic.v_typeCode = typeCode;
	if (typeCode==-1)
		return dynamic;

	dynamic.v_type = type;
	switch(typeCode)
	{
		case 1://'FString':
		{
			FString fstr = *(FString *)val; 
			dynamic.v_str = _strdup(TCHAR_TO_UTF8(*fstr)); //needs a copy
		}
		break; 
		case 2://'Float':
		{
			dynamic.v_float = *(float *)val;
		}
		break; 
		case 3://'int':
		{
			dynamic.v_int = *(int *)val;
		}
		case 4://'bool':
		{
			dynamic.v_bool = *(bool *)val;
		}
		case 5://'FHaxeObject':
		{
			// dynamic.v_dynamic = *val;
		}
		break; 
		case 6://'char*':
		{
			dynamic.v_str = (char*)val;
		}
		break; 
		default:
		{

		}
	}

	return dynamic;
}
 */