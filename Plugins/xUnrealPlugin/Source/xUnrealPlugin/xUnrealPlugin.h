// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Modules/ModuleManager.h"
#include <../_hxlib/xUnreal.h>

bool haxeRunning = false;
HaxeObject haxeMainInstance;
HaxeObject hxInst;

class FxUnrealPluginModule : public IModuleInterface
{
public:

	/** IModuleInterface implementation */
	virtual void StartupModule() override;
	virtual void ShutdownModule() override;
};
