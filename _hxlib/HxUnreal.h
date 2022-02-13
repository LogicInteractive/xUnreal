#pragma once

#include "../Binaries/haxe_build/HxUnrealMain.h"

FString inline _HaxeStringToFString(HaxeString hStr)
{
	FString str(hStr);
	HxUnrealMain_releaseHaxeString(hStr);
	return FString(hStr);    
}
