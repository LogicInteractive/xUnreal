#include "AutoActor.h"

void AAutoActor::StoreTransform()
{
    FTransform at = GetActorTransform();
    Transform _actorTransform;
    _actorTransform.Translation.x = at.GetLocation().X;
    _actorTransform.Translation.y = at.GetLocation().Y;
    _actorTransform.Translation.z = at.GetLocation().Z;
    _actorTransform.Rotation.x = at.GetRotation().Euler().X;
    _actorTransform.Rotation.y = at.GetRotation().Euler().Y;
    _actorTransform.Rotation.z = at.GetRotation().Euler().Z;
    _actorTransform.Scale3D.x = at.GetScale3D().X;
    _actorTransform.Scale3D.y = at.GetScale3D().Y;
    _actorTransform.Scale3D.z = at.GetScale3D().Z;
    HxUnrealMain_unreal_Actor_setActorTransform_inp(hxInst,_actorTransform);
}

void AAutoActor::BeginPlay()
{
    PrimaryActorTick.bCanEverTick = true;
    PrimaryActorTick.bStartWithTickEnabled = true;

    if (hxInst)
        HxUnrealMain_releaseHaxeObject(hxInst); 

	if (!hxInst)
    {
        hxInst = HxUnrealMain_AutoActor_new();
        HxUnrealMain_unreal_Actor_setOwner(hxInst, this);
        StoreTransform();
    }

    if (hxInst)
        HxUnrealMain_unreal_Actor_BeginPlay(hxInst);

    Super::BeginPlay();
}

void AAutoActor::EndPlay(const EEndPlayReason::Type EndPlayReason)
{
    if (hxInst)
        HxUnrealMain_unreal_Actor_EndPlay(hxInst);

    if (hxInst)
        HxUnrealMain_releaseHaxeObject(hxInst); 

    Super::EndPlay(EndPlayReason);
}

void AAutoActor::Tick(float DeltaSeconds)
{
    if (hxInst)
    {
        StoreTransform();
        HxUnrealMain_unreal_Actor_Tick(hxInst,DeltaSeconds);
    }

    Super::Tick(DeltaSeconds);
}
