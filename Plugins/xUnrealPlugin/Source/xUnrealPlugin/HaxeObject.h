#pragma once

#include <../Binaries/haxe_build/xUnrealMain.h>
#include "HaxeObject.generated.h"

USTRUCT(BlueprintType)
struct FHaxeObject
{
    GENERATED_BODY()
    FHaxeObject() {}
	HaxeObject Dynamic;
};
