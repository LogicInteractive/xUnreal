#pragma once

#include "CoreMinimal.h"
#include "Blueprint/UserWidget.h"
#include <../_hxlib/HxUnreal.h>
#include "TestUserWidget.generated.h"

UCLASS(Abstract)
class UTestUserWidget : public UUserWidget
{
	GENERATED_BODY()
	
public:   
	virtual void NativeConstruct() override;

	UFUNCTION(BlueprintPure, Category = "hxUnreal")
	FString getSomeText();
	UFUNCTION(BlueprintCallable, Category = "hxUnreal")
	int getSomeInt();
	UFUNCTION(BlueprintCallable, Category = "hxUnreal")
	float getSomeFloat();
	UFUNCTION(BlueprintPure, CallInEditor, Category = "hxUnreal")
	bool getSomeBool();


private:
	HaxeObject hxInst;
};
