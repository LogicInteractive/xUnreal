#include "BPLatentTaskNode.h"

UBPLatentTaskNode::UBPLatentTaskNode(const FObjectInitializer& ObjectInitializer)	: Super(ObjectInitializer)
{

}

void UBPLatentTaskNode::ExecuteComplete()
{
	Completed.Broadcast();
}

void UBPLatentTaskNode::ExecuteFailed()
{
	Failed.Broadcast();
}
