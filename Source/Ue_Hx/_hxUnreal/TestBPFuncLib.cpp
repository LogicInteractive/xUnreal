#include "TestBPFuncLib.h"

UTestBPFuncLib::UTestBPFuncLib(const FObjectInitializer& ObjectInitializer)	: Super(ObjectInitializer) {}

FString UTestBPFuncLib::whatsup()
{
	return _HaxeStringToFString(HxUnrealMain_TestBPFuncLib_whatsup());
}

