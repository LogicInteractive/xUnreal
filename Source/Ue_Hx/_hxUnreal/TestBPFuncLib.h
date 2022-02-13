#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include <../_hxlib/HxUnreal.h>
#include "TestBPFuncLib.generated.h"

UCLASS()
class UTestBPFuncLib : public UBlueprintFunctionLibrary
{
	GENERATED_UCLASS_BODY()
	
	UFUNCTION(BlueprintCallable, BlueprintPure, Category = "hxUnreal|My testBP lib")
	static FString whatsup();


private:
	static HaxeObject hxInst;
};