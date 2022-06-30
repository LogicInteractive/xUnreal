// Copyright Epic Games, Inc. All Rights Reserved.

#include "xUnrealPlugin.h"

#define LOCTEXT_NAMESPACE "FxUnrealPluginModule"
IMPLEMENT_MODULE(FxUnrealPluginModule, xUnrealPlugin)
DEFINE_LOG_CATEGORY(Haxe);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void onHaxeException(const char* info)
{
    XUnrealMain_stopHaxeThreadIfRunning(false);	// stop the haxe thread immediately

    if (GEngine != NULL)
        GEngine->AddOnScreenDebugMessage(-1, 15.f, FColor::Red, info);
}

void FxUnrealPluginModule::StartupModule()
{
    if (!haxeRunning)
    {
        XUnrealMain_initializeHaxeThread(onHaxeException); // start the haxe thread
        haxeRunning = true;
    }

    if (!haxeMainInstance)
    {
        XUnrealMain_unreal_GEngine_init(TCHAR_TO_UTF8(*FPaths::LaunchDir()));
        haxeMainInstance = XUnrealMain_new();
    }
}

void FxUnrealPluginModule::ShutdownModule()
{
    if (haxeMainInstance)
        XUnrealMain_releaseHaxeObject(haxeMainInstance); // when we're done with our object we can tell the haxe-gc we're finished
    XUnrealMain_stopHaxeThreadIfRunning(true); // stop the haxe thread but wait for any scheduled events to complete
}

#undef LOCTEXT_NAMESPACE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void printToScreen(HaxeString str)
{
    FString s = _HaxeStringToFString(str);
    if (GEngine != NULL)
        GEngine->AddOnScreenDebugMessage(-1, 10.f, FColor::Green, *s);

    XUnrealMain_releaseHaxeString(str);
}

void logMessage(HaxeString str)
{
    FString s = _HaxeStringToFString(str);
    UE_LOG(Haxe, Log, TEXT("%s"), *s);
    XUnrealMain_releaseHaxeString(str);
}

double _getTimeSeconds()
{
    UWorld* World = GEngine->GetWorldContexts()[0].World();
    if (World)
    {
        double now = World->GetTimeSeconds();
        return now;
    }
    else
        return 0;
}

void _setActorLocation(void* p, Vector3* vec)
{
    AActor* ap = ((AActor*)p);
    ap->SetActorLocation(FVector(vec->x, vec->y, vec->z));
}

void _setActorRotation(void* p, Vector3* vec)
{
    AActor* ap = ((AActor*)p);
    ap->SetActorRotation(FRotator::MakeFromEuler(FVector(vec->x, vec->y, vec->z)));
}

void _setActorScale3D(void* p, Vector3* vec)
{
    AActor* ap = ((AActor*)p);
    ap->SetActorScale3D(FVector(vec->x, vec->y, vec->z));
}

void _getActorLocation(void* p, Vector3* vec)
{
    AActor* ap = ((AActor*)p);
    FVector loc = ap->GetActorLocation();
    vec->x = loc.X;
    vec->y = loc.Y;
    vec->z = loc.Z;
}

void _getActorTransform(void* p, Transform* tr)
{
    AActor* ap = ((AActor*)p);
    FTransform t = ap->GetActorTransform();
    tr->Translation.x = t.GetLocation().X;
    tr->Translation.y = t.GetLocation().Y;
    tr->Translation.z = t.GetLocation().Z;
    tr->Rotation.x = t.GetRotation().Euler().X;
    tr->Rotation.y = t.GetRotation().Euler().Y;
    tr->Rotation.z = t.GetRotation().Euler().Z;
    tr->Scale3D.x = t.GetScale3D().X;
    tr->Scale3D.y = t.GetScale3D().Y;
    tr->Scale3D.z = t.GetScale3D().Z;
}

void _setActorTransform(void* p, Transform* tr)
{
    AActor* ap = ((AActor*)p);
    ap->SetActorTransform(
        {
            FRotator{(float)tr->Rotation.x,(float)tr->Rotation.y,(float)tr->Rotation.z},
            FVector{(float)tr->Translation.x,(float)tr->Translation.y,(float)tr->Translation.z},
            FVector{(float)tr->Scale3D.x,(float)tr->Scale3D.y,(float)tr->Scale3D.z}
        });
}

void _getActorRotation(void* p, Vector3* vec)
{
    AActor* ap = ((AActor*)p);
    FVector rot = ap->GetActorRotation().Euler();
    vec->x = rot.X;
    vec->y = rot.Y;
    vec->z = rot.Z;
}

void _getActorScale3D(void* p, Vector3* vec)
{
    AActor* ap = ((AActor*)p);
    FVector sc = ap->GetActorScale3D();
    vec->x = sc.X;
    vec->y = sc.Y;
    vec->z = sc.Z;
}

void _getPrimaryActorTickCanEverTick(void* p, bool* b)
{
    AActor* ap = ((AActor*)p);
    *b = ap->PrimaryActorTick.bCanEverTick;
}
void _setPrimaryActorTickCanEverTick(void* p, bool* b)
{
    AActor* ap = ((AActor*)p);
    ap->PrimaryActorTick.bCanEverTick = *b;
}

void _getPrimaryActorTickStartWithTickEnabled(void* p, bool* b)
{
    AActor* ap = ((AActor*)p);
    *b = ap->PrimaryActorTick.bStartWithTickEnabled;
}
void _setPrimaryActorTickStartWithTickEnabled(void* p, bool* b)
{
    AActor* ap = ((AActor*)p);
    ap->PrimaryActorTick.bStartWithTickEnabled = *b;
}

void _setTickFunctionEnable(void* p, bool* b)
{
    AActor* ap = ((AActor*)p);
    ap->SetActorTickEnabled(true);
}
