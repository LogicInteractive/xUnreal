#pragma once

#include "CoreMinimal.h"
#include "Engine/GameInstance.h"
#include "XUnrealGameInstance.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(FXEvent, FString, EventName, FString, Payload);

UCLASS()
class UXUnrealGameInstance : public UGameInstance
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintAssignable)
	FXEvent GlobalEvent;

public:
	UXUnrealGameInstance();
};
