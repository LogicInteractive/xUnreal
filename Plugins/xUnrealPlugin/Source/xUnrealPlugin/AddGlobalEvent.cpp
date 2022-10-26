#include "AddGlobalEvent.h"
#include "XUnrealGameInstance.h"
#include "XUnrealBPFL.h"

UAddGlobalEvent::UAddGlobalEvent(const FObjectInitializer& ObjectInitializer) : Super(ObjectInitializer) {}

UAddGlobalEvent* UAddGlobalEvent::AddGlobalEventListener(FString EventName)
{
	UAddGlobalEvent* Node = NewObject<UAddGlobalEvent>();
	if (Node)
	{
		Node->EventNameStr=EventName;
	}
	return Node;
}

void UAddGlobalEvent::Activate()
{
	UXUnrealGameInstance* gInst = UXUnrealBPFL::XUnrealGameInstance();
	if (gInst)
	{
		gInst->GlobalEvent.AddDynamic(this, &UAddGlobalEvent::OnGlobalEvent);
	}
}

void UAddGlobalEvent::OnGlobalEvent(FString EventName, FString Payload)
{
	if (EventNameStr == EventName)
	{
		OnEvent.Broadcast(Payload);
	}
}

void UAddGlobalEvent::SetReadyToDestroy()
{
	UXUnrealGameInstance* gInst = UXUnrealBPFL::XUnrealGameInstance();
	if (gInst)
	{
		gInst->GlobalEvent.RemoveDynamic(this, &UAddGlobalEvent::OnGlobalEvent);
	}

	Super::SetReadyToDestroy();
}
