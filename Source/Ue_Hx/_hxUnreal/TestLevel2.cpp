#include "TestLevel2.h"

void ATestLevel2::BeginPlay()
{
    PrimaryActorTick.bCanEverTick = true;
    PrimaryActorTick.bStartWithTickEnabled = true;

    if (hxInst)
        HxUnrealMain_releaseHaxeObject(hxInst); 

	if (!hxInst)
    {
        hxInst = HxUnrealMain_TestLevel2_new();
        HxUnrealMain_unreal_Actor_setOwner(hxInst, this);
    }

    if (hxInst)
        HxUnrealMain_unreal_Actor_BeginPlay(hxInst);

    Super::BeginPlay();
}

void ATestLevel2::EndPlay(const EEndPlayReason::Type EndPlayReason)
{
    if (hxInst)
        HxUnrealMain_unreal_Actor_EndPlay(hxInst);

    if (hxInst)
        HxUnrealMain_releaseHaxeObject(hxInst); 

    Super::EndPlay(EndPlayReason);
}

void ATestLevel2::Tick(float DeltaSeconds)
{
    if (hxInst)
    {
        HxUnrealMain_unreal_Actor_Tick(hxInst,DeltaSeconds);
    }

    Super::Tick(DeltaSeconds);
}
