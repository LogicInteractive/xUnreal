#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintAsyncActionBase.h"
#include <../_hxlib/xUnreal.h>
#include "BPLatentTaskNode.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE(FBPNodeOutputPin);

UCLASS()
class UBPLatentTaskNode : public UBlueprintAsyncActionBase
{
	GENERATED_UCLASS_BODY()
	
public:
	UPROPERTY(BlueprintAssignable)
	FBPNodeOutputPin Completed;
	UPROPERTY(BlueprintAssignable)
	FBPNodeOutputPin Failed;

	void ExecuteComplete();
	void ExecuteFailed();
};