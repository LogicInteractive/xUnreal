#ifndef HxUnrealExt_h
#define HxUnrealExt_h

/*
#define WITH_EDITOR 1
#define WITH_ENGINE 1
#define UE_BUILD_DEVELOPMENT 1
#define WITH_UNREAL_DEVELOPER_TOOLS 1
#define WITH_PLUGIN_SUPPORT 1
#define IS_MONOLITHIC 0
#define IS_PROGRAM 1
#define UBT_COMPILED_PLATFORM "x64"
// // #include "e:/Unreal/UE_4.27/Engine/Source/Runtime/Core/Public/CoreMinimal.h"
// #include "e:/Unreal/UE_4.27/Engine/Source/Runtime/Core/Public/a.h"
*/

typedef const char* HaxeString;

void inline printToScreen(HaxeString str);
void inline logMessage(HaxeString str);
double inline getTime();
void inline _setActorLocation(void* p,double x,double y,double z);
void inline _setActorRotation(void* p,double x,double y,double z);
void inline _setActorScale3D(void* p,double x,double y,double z);

#endif