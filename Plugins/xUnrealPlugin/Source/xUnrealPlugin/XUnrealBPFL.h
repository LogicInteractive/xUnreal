#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include <../_hxlib/xUnreal.h>
#include "HaxeObject.h"
#include "XUDynamicType.h"
#include "XUnrealBPFL.generated.h"

UCLASS()
class UXUnrealBPFL : public UBlueprintFunctionLibrary
{
	GENERATED_UCLASS_BODY()
	
	// UFUNCTION(BlueprintCallable, Category = "xUnreal")
	static UWorld* GetGlobalWorld();	

	UFUNCTION(BlueprintCallable, BlueprintPure, Category = "xUnreal", meta = (WorldContext="WorldContextObject"))
	static UXUnrealGameInstance* XUnrealGameInstance();	
	
	UFUNCTION(BlueprintCallable, Category = "xUnreal", meta = (WorldContext="WorldContextObject"))
	static UObject* NewXUnrealUObject(TSubclassOf<class UObject> xUnrealUObjectClass);
	
	UFUNCTION(BlueprintCallable, Category = "xUnreal")
	static void DispatchGlobalEvent(FString EventName, FString Payload);
	
	UFUNCTION(BlueprintCallable, Category = "xUnreal")
	static void CallDynamicMulticastDelegateByName(UObject* DelegateOwner, const FName DelegateName);
	
	UFUNCTION(BlueprintCallable, Category = "xUnreal")
	static bool XDynamicToBool(FXUDynamicType dynamic);

	UFUNCTION(BlueprintCallable, Category = "xUnreal")
	static int XDynamicToInt(FXUDynamicType dynamic);

	UFUNCTION(BlueprintCallable, Category = "xUnreal")
	static float XDynamicToFloat(FXUDynamicType dynamic);
	
	UFUNCTION()
	static void CallXUnrealDelegateByName(UObject* DelegateOwner, const FName DelegateName, FXUDynamicType Param1, FXUDynamicType Param2, FXUDynamicType Param3);

	// static void DrawCustomVerts(const FOnPaintHandlerParams& InParams);

};