#pragma once

#include "../Binaries/haxe_build/xUnrealMain.h"
#include "HaxeObject.h"
#include "XUDynamicType.h"
#include "unreal/types/HaxeArray.h"
#include "unreal/types/IntArray.h"
#include "unreal/types/FloatArray.h"
#include "unreal/types/StringArray.h"
#include "unreal/types/DynamicWrapper.h"
#include "unreal/types/Vector2D.h"
#include "unreal/types/Vector3.h"

DECLARE_LOG_CATEGORY_EXTERN(Haxe, Log, All);
DECLARE_MULTICAST_DELEGATE(FXUnrealGlobalEvent);

extern bool haxeRunning = false;

FString inline _HaxeStringToFString(HaxeString hStr)
{
	FString r = UTF8_TO_TCHAR(hStr);
	XUnrealMain_releaseHaxeString(hStr);
	return r;    	
}

FHaxeObject inline _HaxeObjectToUE(HaxeObject hxObj)
{
	FHaxeObject obj;
	obj.Dynamic = hxObj;
	return obj;
}

HaxeObject inline _UEToHaxeObject(FHaxeObject fObj)
{
	HaxeObject hxObj = fObj.Dynamic;
	return hxObj;
}

FVector inline _HaxeVector3ToUE(Vector3 vec)
{
	return FVector(vec.x,vec.y,vec.z);
}

FVector2D inline _HaxeVector2DToUE(Vector2D vec)
{
	return FVector2D(vec.x,vec.y);
}

Vector2D inline _UEToHaxeVector2D(FVector2D ueVec)
{
	Vector2D vec;
	vec.x = ueVec.X;
	vec.y = ueVec.Y;
	return vec;
}

Vector3 inline _UEToHaxeVector3(FVector ueVec)
{
	Vector3 vec;
	vec.x = ueVec.X;
	vec.y = ueVec.Y;
	vec.z = ueVec.Z;
	return vec;
}

TArray<int> inline _HaxeIntArrayToUE(IntArray arrIn)
{
	TArray<int> arrOut;
	int* pArr = (int*)arrIn.v_ptr;
	int array_size = arrIn.v_length;
	for(int i = 0; i < array_size; i++)
		arrOut.Add(pArr[i]);

	// auto arrz = *pArr[0];
	// int arrg[] = {1,2,3,4};
	// TArray<int> arrOut2;
	// // arrOut2.Append(*pArr[0], UE_ARRAY_COUNT(20));
	return arrOut;
}

IntArray inline _UEToHaxeIntArray(TArray<int> arrIn)
{
	IntArray arrOut;
	int len = arrIn.Num();
	arrOut.v_ptr = calloc(len, sizeof(int));
	int* a = (int*)arrOut.v_ptr;
	for(int i = 0; i < len; i++)
		a[i]=arrIn[i];
	arrOut.v_length = len;
	return arrOut;
}

FloatArray inline _UEToHaxeFloatArray(TArray<double> arrIn)
{
	FloatArray arrOut;
	int len = arrIn.Num();
	arrOut.v_ptr = calloc(len, sizeof(double));
	double* a = (double*)arrOut.v_ptr;
	for(int i = 0; i < len; i++)
		a[i]=arrIn[i];
	arrOut.v_length = len;
	return arrOut;
}

StringArray inline _UEToHaxeStringArray(TArray<FString> arrIn)
{
	StringArray arrOut;
	int len = arrIn.Num();
	arrOut.v_ptr = calloc(len, sizeof(char*));
	char** a = (char**)arrOut.v_ptr;
	for(int i = 0; i < len; i++)
		a[i]=_strdup(TCHAR_TO_UTF8(*arrIn[i]));
	arrOut.v_length = len;
	return arrOut;
}

TArray<double> inline _HaxeFloatArrayToUE(FloatArray arrIn)
{
	TArray<double> arrOut;
	double* pArr = (double*)arrIn.v_ptr;
	int array_size = arrIn.v_length;
	for(int i = 0; i < array_size; i++)
		arrOut.Add(pArr[i]);
	return arrOut;
}

TArray<FString> inline _HaxeStringArrayToUE(StringArray arrIn)
{
	TArray<FString> arrOut;
	HaxeString* pArr = (HaxeString*)arrIn.v_ptr;
	int array_size = arrIn.v_length;
	for(int i = 0; i < array_size; i++)
		arrOut.Add(_HaxeStringToFString((HaxeString)pArr[i]));
	return arrOut;
}

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

// HaxeString inline _FStringToHaxeString(FString str)
// {
// 	const TCHAR *s = *str;
// 	return TCHAR_TO_UTF8(*str);
// }

// HaxeString inline _FStringToHaxeString2(const TCHAR *str)
// {
// 	return TCHAR_TO_UTF8(str);
// }

// HaxeString inline _FStringToHaxeString3(FString str*)
// {
// 	const TCHAR *s = *str;
// 	return TCHAR_TO_UTF8(*str);
// }

// void _setActorLocation(void* p, Vector3* vec)
// {
//     AActor* ap = ((AActor*)p);
//     ap->SetActorLocation(FVector(vec->x, vec->y, vec->z));
// }

// void _setActorRotation(void* p, Vector3* vec)
// {
//     AActor* ap = ((AActor*)p);
//     ap->SetActorRotation(FRotator::MakeFromEuler(FVector(vec->x, vec->y, vec->z)));
// }

// void _setActorScale3D(void* p, Vector3* vec)
// {
//     AActor* ap = ((AActor*)p);
//     ap->SetActorScale3D(FVector(vec->x, vec->y, vec->z));
// }
