// Copyright Epic Games, Inc. All Rights Reserved.

#include "xUnrealPlugin.h"
#include "XUnrealGameInstance.h"
#include "Async/Async.h"
#include "Engine/TriggerBox.h"
#include "Blueprint/WidgetBlueprintLibrary.h"
#include "XUnrealBPFL.h"

#define LOCTEXT_NAMESPACE "FxUnrealPluginModule"
IMPLEMENT_MODULE(FxUnrealPluginModule, xUnrealPlugin)
DEFINE_LOG_CATEGORY(Haxe);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

HaxeObject haxeMainInstance;

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
        UE_LOG(Haxe, Log, TEXT("Haxe mainthread initialized"));
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
    UE_LOG(Haxe, Log, TEXT("Haxe mainthread stopped"));
}

#undef LOCTEXT_NAMESPACE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void printToScreen(HaxeString str, float timeToDisplay)
{
    FString s = _HaxeStringToFString(str);
    if (GEngine != NULL)
        GEngine->AddOnScreenDebugMessage(-1, timeToDisplay, FColor::Green, *s);

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
    AsyncTask(ENamedThreads::GameThread, [=]()
    {
        AActor* ap = ((AActor*)p);
        ap->SetActorLocation(FVector(vec->x, vec->y, vec->z));
    });
}

void _setActorRotation(void* p, Vector3* vec)
{
    AsyncTask(ENamedThreads::GameThread, [=]()
    {
        AActor* ap = ((AActor*)p);
        ap->SetActorRotation(FRotator::MakeFromEuler(FVector(vec->x, vec->y, vec->z)));
    });
}

void _setActorScale3D(void* p, Vector3* vec)
{
    AsyncTask(ENamedThreads::GameThread, [=]()
    {
        AActor* ap = ((AActor*)p);
        ap->SetActorScale3D(FVector(vec->x, vec->y, vec->z));
    });
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
    AsyncTask(ENamedThreads::GameThread, [=]()
    {
        AActor* ap = ((AActor*)p);
        ap->SetActorTransform(
            {
                FRotator{(float)tr->Rotation.x,(float)tr->Rotation.y,(float)tr->Rotation.z},
                FVector{(float)tr->Translation.x,(float)tr->Translation.y,(float)tr->Translation.z},
                FVector{(float)tr->Scale3D.x,(float)tr->Scale3D.y,(float)tr->Scale3D.z}
            });
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
    AsyncTask(ENamedThreads::GameThread, [=]()
    {
        AActor* ap = ((AActor*)p);
        ap->PrimaryActorTick.bCanEverTick = *b;
    });
}

void _getPrimaryActorTickStartWithTickEnabled(void* p, bool* b)
{
    AActor* ap = ((AActor*)p);
    *b = ap->PrimaryActorTick.bStartWithTickEnabled;
}
void _setPrimaryActorTickStartWithTickEnabled(void* p, bool* b)
{
    AsyncTask(ENamedThreads::GameThread, [=]()
    {
        AActor* ap = ((AActor*)p);
        ap->PrimaryActorTick.bStartWithTickEnabled = *b;
    });
}

void _setTickFunctionEnable(void* p, bool* b)
{
    AsyncTask(ENamedThreads::GameThread, [=]()
    {   
        AActor* ap = ((AActor*)p);
        ap->SetActorTickEnabled(true);
    });
}

void _callLatentTaskNode(void* p, int task)
{
    UBPLatentTaskNode* aab = ((UBPLatentTaskNode*)p);
    if (task==0)
        aab->ExecuteComplete();
    else if (task==1)
        aab->ExecuteFailed();
}

void _callGlobalEvent(HaxeString EventName, HaxeString Payload)
{
    if (GEngine==NULL || !haxeRunning)
        return;

    FString evName = _HaxeStringToFString(EventName);
    FString pLoad = _HaxeStringToFString(Payload);
    UXUnrealGameInstance* gi = UXUnrealBPFL::XUnrealGameInstance();
    if (gi==NULL)
        return;
    if (gi->GlobalEvent.IsBound())
        gi->GlobalEvent.Broadcast(evName,pLoad);
}

void _delegateBroadcast(void* owner, const char* delegateName)
{
    // if (GEngine != NULL)
        // GEngine->AddOnScreenDebugMessage(-1, 25.f, FColor::White, delegateName);
}

// void _callDynamicMulticastDelegateByName(void* owner, HaxeString delegateName, HaxeString param1, HaxeString param2, HaxeString param3)
void _callDynamicMulticastDelegateByName(void* owner, HaxeString delegateName, DynamicWrapper* param1, DynamicWrapper* param2, DynamicWrapper* param3)
{
    if (!owner)
        return;

    UObject* obj = ((UObject*)owner);
    FName dName= FName(_HaxeStringToFString(delegateName));
    // FString _param1 = _HaxeStringToFString(param1);
    // FString _param2 = _HaxeStringToFString(param2);
    // FString _param3 = _HaxeStringToFString(param3);
    FXUDynamicType p1;
    FXUDynamicType p2;
    FXUDynamicType p3;

    if (param1!=NULL)
        p1.dynamic = *param1;
    if (param2!=NULL)
        p2.dynamic = *param2;
    if (param3!=NULL)
        p3.dynamic = *param3;

    UXUnrealBPFL::CallXUnrealDelegateByName(obj, dName, p1, p2, p3);
}

void _DrawLine(void* Context, Vector2D PositionA, Vector2D PositionB, uint32_t Tint, bool bAntiAlias, float Thickness)
{
    // FSlateColorBrush brushClr = FSlateColorBrush(FColor(Tint));
    FLinearColor col = FLinearColor(FColor(Tint));
    FPaintContext con = *(FPaintContext*)Context;
    UWidgetBlueprintLibrary::DrawLine(con, _HaxeVector2DToUE(PositionA), _HaxeVector2DToUE(PositionB), col, bAntiAlias, Thickness);
}

void _DrawLines(void* Context, FloatArray Points, uint32_t Tint, bool bAntiAlias, float Thickness)
{
    FLinearColor col = FLinearColor(FColor(Tint));
    FPaintContext con = *(FPaintContext*)Context;
    TArray<FVector2D> pts;
    const TArray<double> fa = _HaxeFloatArrayToUE(Points);
  	for(int i = 0; i < fa.Num(); i+=2)
        pts.Add(FVector2D(fa[i],fa[i+1]));
    UWidgetBlueprintLibrary::DrawLines(con, pts, col, bAntiAlias, Thickness);
}

void _DrawText(void* Context, HaxeString string, double x, double y, uint32_t Tint)
{
    // int32 FontSize, FName FontTypeFace,
    //DrawTextFormatted(FPaintContext& Context, const FText& Text, FVector2D Position, UFont* Font, int32 FontSize, FName FontTypeFace, FLinearColor Tint)
    
    FLinearColor col = FLinearColor(FColor(Tint));
    FPaintContext con = *(FPaintContext*)Context;
    UWidgetBlueprintLibrary::DrawText(con, _HaxeStringToFString(string), FVector2D(x,y), col);
}

bool _actorHasTag(void* actor, HaxeString tag)
{
    AActor* a = ((AActor*)actor);    
    return a->ActorHasTag(FName(_HaxeStringToFString(tag)));    
}

// void _DrawBox(void* Context, double x, double y, double width, double height, uint32_t Tint)
// {
//     FPaintContext con = *(FPaintContext*)Context;
//      UWidgetBlueprintLibrary::DrawBox(con, FVector2D(x,y), FVector2D(width,height), USlateBrushAsset* Brush, FLinearColor::White)
// }

// void _TriggerCurrentOverlaps(void* owner)
// {
//     ATriggerBox* o = (ATriggerBox*)owner;
//     TArray<AActor*> Result;
//     o->GetOverlappingActors(Result,AActor::StaticClass());
//     if (!hxInst)
//         return;

//   	for(int i = 0; i < Result.Num(); i++)
//     {
//         if (Result[i] && (Result[i] != this))
//             {$hxMainClass}_unreal_TriggerBox_OnOverlapBeginInternal(hxInst,Result[i],TCHAR_TO_UTF8(*Result[i]->GetName()));
//     }
// }
