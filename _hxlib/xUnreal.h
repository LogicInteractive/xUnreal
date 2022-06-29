#pragma once

#include "../Binaries/haxe_build/xUnrealMain.h"

DECLARE_LOG_CATEGORY_EXTERN(Haxe, Log, All);

FString inline _HaxeStringToFString(HaxeString hStr)
{
	FString r = UTF8_TO_TCHAR(hStr);
	XUnrealMain_releaseHaxeString(hStr);
	return r;    	
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
