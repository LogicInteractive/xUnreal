#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintAsyncActionBase.h"
#include <../_hxlib/xUnreal.h>
#include "AddGlobalEvent.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FGlobalEventPint, FString, Payload);

UCLASS()
class UAddGlobalEvent : public UBlueprintAsyncActionBase
{
	GENERATED_UCLASS_BODY()
	
public:
	UPROPERTY(BlueprintAssignable)
	FGlobalEventPint OnEvent;

	UPROPERTY()
	FString EventNameStr;

	UFUNCTION(BlueprintCallable, meta = (BlueprintInternalUseOnly = "true", Category = "xUnreal|GlobalEvent"))
	static UAddGlobalEvent* AddGlobalEventListener(FString EventName);

	UFUNCTION()
	void OnGlobalEvent(FString EventName, FString Payload);

	virtual void Activate() override;
	virtual void SetReadyToDestroy() override;

private:
};