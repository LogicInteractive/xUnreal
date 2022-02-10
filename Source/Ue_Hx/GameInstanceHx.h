#pragma once

#include "CoreMinimal.h"
#include "Engine/GameInstance.h"
#include <../_hxlib/HxUnreal.h>
#include "GameInstanceHx.generated.h"

static bool haxeRunning = false;
static HaxeObject haxeMainInstance;

UCLASS()
class UE_HX_API UGameInstanceHx : public UGameInstance
{
	GENERATED_BODY()

public:
    UGameInstanceHx();

    virtual void Init() override;
    virtual void Shutdown() override;

	HaxeObject hxInst;
};
