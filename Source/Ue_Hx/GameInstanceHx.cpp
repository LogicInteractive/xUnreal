#include "GameInstanceHx.h"

/////////////////////////////////////////////////////////////////////////////////////

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