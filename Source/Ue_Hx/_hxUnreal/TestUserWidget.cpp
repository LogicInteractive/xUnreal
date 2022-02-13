#include "TestUserWidget.h"

void UTestUserWidget::NativeConstruct()
{
    if (hxInst)
        HxUnrealMain_releaseHaxeObject(hxInst); 

	if (!hxInst)
    {
        hxInst = HxUnrealMain_TestUserWidget_new();
        HxUnrealMain_unreal_UWidget_setOwner(hxInst, this);
    }

    if (hxInst)
        HxUnrealMain_unreal_UserWidget_NativeConstruct(hxInst);

	Super::NativeConstruct();
}

FString UTestUserWidget::getSomeText()
{
	return _HaxeStringToFString(HxUnrealMain_TestUserWidget_getSomeText(hxInst));
}
int UTestUserWidget::getSomeInt()
{
	return (HxUnrealMain_TestUserWidget_getSomeInt(hxInst));
}
float UTestUserWidget::getSomeFloat()
{
	return (HxUnrealMain_TestUserWidget_getSomeFloat(hxInst));
}
bool UTestUserWidget::getSomeBool()
{
	return (HxUnrealMain_TestUserWidget_getSomeBool(hxInst));
}
