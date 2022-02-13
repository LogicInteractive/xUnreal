#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include <../_hxlib/HxUnreal.h>
#include "ActorExample.generated.h"

UCLASS()
class AActorExample : public AActor
{
	GENERATED_BODY()
	
public:   
	virtual void BeginPlay() override;
	virtual void EndPlay(const EEndPlayReason::Type EndPlayReason) override;  
	virtual void Tick(float DeltaSeconds) override; 

private:
	HaxeObject hxInst;
	void StoreTransform();
};