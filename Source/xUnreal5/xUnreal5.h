#pragma once
#include <../_hxlib/xUnreal.h>
#include "CoreMinimal.h"

bool haxeRunning = false;
HaxeObject haxeMainInstance;
HaxeObject hxInst;

class FxUnreal5 : public IModuleInterface
{

public:
	virtual void StartupModule() override;
	virtual void ShutdownModule() override;

};