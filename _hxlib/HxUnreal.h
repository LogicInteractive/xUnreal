// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "../Binaries/haxe_build/HxUnrealMain.h"

#ifndef MXM_G
#define MXM_G

void inline onHaxeException(const char* info)
{
    HxUnrealMain_stopHaxeThreadIfRunning(false);	// stop the haxe thread immediately

    if (GEngine != NULL)
        GEngine->AddOnScreenDebugMessage(-1, 15.f, FColor::Red, info);
}

void inline printToScreen(HaxeString str)
{
	if (GEngine != NULL)
		GEngine->AddOnScreenDebugMessage(-1, 10.f, FColor::Green, str);

    HxUnrealMain_releaseHaxeString(str);
}

void inline logMessage(HaxeString str)
{
    FString s(str);
    UE_LOG(LogTemp, Log, TEXT("%s"),*s);		
    HxUnrealMain_releaseHaxeString(str);
}

double inline getTime()
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

void inline _setActorLocation(void* p,double x,double y,double z)
{
    AActor *ap = ((AActor *)p);
    ap->SetActorLocation(FVector(x,y,z));
}

void inline _setActorRotation(void* p,double x,double y,double z)
{
    AActor *ap = ((AActor *)p);
    ap->SetActorRotation(FRotator::MakeFromEuler(FVector(x,y,z)));  
}

void inline _setActorScale3D(void* p,double x,double y,double z)
{
    AActor *ap = ((AActor *)p);
    ap->SetActorScale3D(FVector(x,y,z)); 
}

FString inline _HaxeStringToFString(HaxeString hStr)
{
	FString str(hStr);
	HxUnrealMain_releaseHaxeString(hStr);
	return FString(hStr);    
}

#endif