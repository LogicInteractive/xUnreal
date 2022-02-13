#include "Ue_Hx.h"
#include <../_hxlib/HxUnreal.h>
#include "Modules/ModuleManager.h"

IMPLEMENT_PRIMARY_GAME_MODULE( FDefaultGameModuleImpl, Ue_Hx, "Ue_Hx" );

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

