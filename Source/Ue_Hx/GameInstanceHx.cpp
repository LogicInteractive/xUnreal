#include "GameInstanceHx.h"

/////////////////////////////////////////////////////////////////////////////////////

void onHaxeException(const char* info)
{
    HxUnrealMain_stopHaxeThreadIfRunning(false);	// stop the haxe thread immediately

    if (GEngine != NULL)
        GEngine->AddOnScreenDebugMessage(-1, 15.f, FColor::Red, info);
}

void printToScreen(HaxeString str)
{
	if (GEngine != NULL)
		GEngine->AddOnScreenDebugMessage(-1, 10.f, FColor::Green, str);

    HxUnrealMain_releaseHaxeString(str);
}

void logMessage(HaxeString str)
{
    FString s(str);
    UE_LOG(LogTemp, Log, TEXT("%s"),*s);		
    HxUnrealMain_releaseHaxeString(str);
}

double getTime()
{
    // double now = FPlatformTime::Seconds();

    UWorld* World = GEngine->GetWorldContexts()[0].World();
    if (World)
    {
        double now = World->GetTimeSeconds();
        return now;
        // UE_LOG(LogTemp, Warning, TEXT("Tick Timer: %.6f"), now);
    }
    else
        return 0;
}

void _setActorLocation(void* p,double x,double y,double z)
{
    AActor *ap = ((AActor *)p);
    ap->SetActorLocation(FVector(x,y,z));
}

void _setActorRotation(void* p,double x,double y,double z)
{
    AActor *ap = ((AActor *)p);
    ap->SetActorRotation(FRotator::MakeFromEuler(FVector(x,y,z)));  
}

void _setActorScale3D(void* p,double x,double y,double z)
{
    AActor *ap = ((AActor *)p);
    ap->SetActorScale3D(FVector(x,y,z)); 
}




UGameInstanceHx::UGameInstanceHx()
{
}

void UGameInstanceHx::Init()
{
	Super::Init();

    if (!haxeRunning)
    {
        HxUnrealMain_initializeHaxeThread(onHaxeException); // start the haxe thread
        haxeRunning = true;
    }

    if (!haxeMainInstance)
    {
        HxUnrealMain_unreal_GEngine_init();
        HxUnrealMain_unreal_World_init(getTime);
        haxeMainInstance = HxUnrealMain_new();
    }

    if (!hxInst)
        hxInst = HxUnrealMain_unreal_GameInstance_new();
}

void UGameInstanceHx::Shutdown()
{
    if (hxInst)
        HxUnrealMain_releaseHaxeObject(hxInst); 

    if (haxeMainInstance)
        HxUnrealMain_releaseHaxeObject(haxeMainInstance); // when we're done with our object we can tell the haxe-gc we're finished

    //Main_stopHaxeThreadIfRunning(true); // stop the haxe thread but wait for any scheduled events to complete
    Super::Shutdown();
}

/////////////////////////////////////////////////////////////////////////////////////
