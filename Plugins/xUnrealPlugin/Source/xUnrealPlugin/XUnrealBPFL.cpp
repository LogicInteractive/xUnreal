#include "XUnrealBPFL.h"
#include "Kismet/GameplayStatics.h"

UXUnrealBPFL::UXUnrealBPFL(const FObjectInitializer& ObjectInitializer)	: Super(ObjectInitializer) {}

UWorld* UXUnrealBPFL::GetGlobalWorld()	
{
	// for(TObjectIterator<UObject> Itr; Itr; ++Itr)
	// {
	// 	if(Itr->GetWorld() != NULL)
	// 		return Itr->GetWorld();
	// }
	// return UXUnrealGameInstance::GetWorld();
	// return NULL;	

	FWorldContext* world = GEngine->GetWorldContextFromGameViewport(GEngine->GameViewport);
	return world->World();
	// return nullptr;
}

// UXUnrealGameInstance* UXUnrealBPFL::XUnrealGameInstance(UObject* WorldContextObject)	
UXUnrealGameInstance* UXUnrealBPFL::XUnrealGameInstance()	
{
	if (!GEngine || !GEngine->GameViewport || !GEngine->GameViewport->GetWorld() || !GEngine->GameViewport->GetWorld()->GetGameInstance())
		return NULL;

	// UWorld* w = WorldContextObject->GetWorld();
	// if (w==NULL)
	// 	return NULL;

	// UGameInstance * gInst = UGameplayStatics::GetGameInstance(w);
	// UGameInstance * gInst = ((UGameEngine*)GEngine)->GameInstance;
	// UXUnrealGameInstance* xGInst = Cast<UXUnrealGameInstance>(gInst);
	// UXUnrealGameInstance* GI = Cast<UXUnrealGameInstance>(UGameplayStatics::GetGameInstance(w));

	UXUnrealGameInstance* xGInst = static_cast<UXUnrealGameInstance*>(GEngine->GameViewport->GetWorld()->GetGameInstance());
	return xGInst;
}

// UObject* UXUnrealBPFL::NewXUnrealUObject(UPARAM(ref) UGenerationModule*& xUnrealUObjectClass)	
UObject* UXUnrealBPFL::NewXUnrealUObject(TSubclassOf<class UObject> xUnrealUObjectClass)	
{
	// UObject* Obj = NewObject<UObject>(NULL,xUnrealUObjectClass::StaticClass());
	TSubclassOf<UObject> item_class = xUnrealUObjectClass->StaticClass();
	UObject* Obj = NewObject<UObject>(GetTransientPackage(),item_class);
	return Obj;

	// TSubclassOf<UItem> item_class = UItemB::StaticClass();
    // UItem* item = NewObject<UItem>(this, item_class);	
}

void UXUnrealBPFL::DispatchGlobalEvent(FString EventName, FString Payload)
{
	XUnrealMain_unreal_GEngine_receiveGlobalEvent(TCHAR_TO_UTF8(*EventName),TCHAR_TO_UTF8(*Payload));

	UXUnrealGameInstance* gi = XUnrealGameInstance();
	if (gi)
		gi->GlobalEvent.Broadcast(EventName,Payload);
}

struct FDGParams
{ 
	FString String;
	int Int;
	float Float;
	bool Bool;
};

void UXUnrealBPFL::CallDynamicMulticastDelegateByName(UObject* DelegateOwner, const FName DelegateName)
{
    if (DelegateOwner)
    {
        FMulticastDelegateProperty* DelegateProp = FindFProperty<FMulticastDelegateProperty>(DelegateOwner->GetClass(), DelegateName); 
        if (DelegateProp)
        {
			void* ValueAddress = DelegateProp->ContainerPtrToValuePtr<void>(DelegateOwner);
			const FMulticastScriptDelegate* DelegateAddr = DelegateProp->GetMulticastDelegate(ValueAddress);

			FDGParams Parameters;
			Parameters.String = DelegateName.ToString();
			DelegateAddr->ProcessMulticastDelegate<UObject>(&Parameters);
        }
		else
		{
		
		}
    }
	// else
	// {
	// 	if (GEngine != NULL)
	// 		GEngine->AddOnScreenDebugMessage(-1, 25.f, FColor::Red, DelegateName.ToString());
	// }

	// for (TFieldIterator<FMulticastDelegateProperty> PropIt(GetClass()); PropIt; ++PropIt)
	// {
	// 	FMulticastDelegateProperty* DelegateProp = *PropIt;
    //     if (DelegateProp)
    //     {
	// 		uint8* Parameters = nullptr;
	// 	    // if (propertyIterator->GetName() == EventName)
    //         // {
	// 		    void* ValueAddress = DelegateProp->ContainerPtrToValuePtr<void>(this);
	// 		    const FMulticastScriptDelegate* DelegateAddr = DelegateProp->GetMulticastDelegate(ValueAddress);
    //             // auto Target = DelegateProp->GetPropertyValuePtr_InContainer(DelegateAddr.Get());
	// 			// Target->Add(Delegate);
    //             // DelegateAddr->Broadcast("HELLO REFLECTION!!!");
    //            	// Target->AddDynamic(this, &UOCGameInst::OnFDOCGameInstEvent1);
    //             // DelegateAddr->ProcessMulticastDelegate<UObject>(Parameters);
	// 	    // }
            
    //         if (GEngine != NULL)
    //             GEngine->AddOnScreenDebugMessage(-1, 25.f, FColor::Cyan, DelegateProp->GetName());

	//     }	
	// }	
}

struct FDParams
{ 
	FXUDynamicType param1;
	FXUDynamicType param2;
	FXUDynamicType param3;
};

void UXUnrealBPFL::CallXUnrealDelegateByName(UObject* DelegateOwner, const FName DelegateName, FXUDynamicType Param1, FXUDynamicType Param2, FXUDynamicType Param3)
{
    if (DelegateOwner)
    {
        FMulticastDelegateProperty* DelegateProp = FindFProperty<FMulticastDelegateProperty>(DelegateOwner->GetClass(), DelegateName); 
        if (DelegateProp)
        {
			void* ValueAddress = DelegateProp->ContainerPtrToValuePtr<void>(DelegateOwner);
			const FMulticastScriptDelegate* DelegateAddr = DelegateProp->GetMulticastDelegate(ValueAddress);

			FDParams Parameters;
			Parameters.param1 = Param1;
			Parameters.param2 = Param2;
			Parameters.param3 = Param3;
			DelegateAddr->ProcessMulticastDelegate<UObject>(&Parameters);
        }
    }
}

bool UXUnrealBPFL::XDynamicToBool(FXUDynamicType dynamic)
{
    if (dynamic.dynamic.v_typeCode == 1)
        return dynamic.dynamic.v_bool;
    else
        return 0;		
}

int UXUnrealBPFL::XDynamicToInt(FXUDynamicType dynamic)
{
		if (dynamic.dynamic.v_typeCode == 3)
			return dynamic.dynamic.v_int;
    else
        return 0;		
}

float UXUnrealBPFL::XDynamicToFloat(FXUDynamicType dynamic)
{
    if (dynamic.dynamic.v_typeCode == 2)
        return dynamic.dynamic.v_float;
    else
        return 0;		
}


// void UXUnrealBPFL::DrawCustomVerts(const FOnPaintHandlerParams& InParams)
// {
    // const float Radius = FMath::Min(InParams.Geometry.GetLocalSize().X, InParams.Geometry.GetLocalSize().Y) * 0.5f;
    // const FVector2D Center = InParams.Geometry.AbsolutePosition + InParams.Geometry.GetLocalSize() * 0.5f;

    // const FSlateBrush* MyBrush = FCoreStyle::Get().GetBrush("ColorWheel.HueValueCircle");
    // // @todo this is not the correct way to do this
    // FSlateShaderResourceProxy* ResourceProxy = FSlateDataPayload::ResourceManager->GetShaderResource(*MyBrush);
    // FSlateResourceHandle Handle = FSlateApplication::Get().GetRenderer()->GetResourceHandle( *MyBrush );

    // FVector2D UVCenter = FVector2D::ZeroVector;
    // FVector2D UVRadius = FVector2D(1,1);
    // if (ResourceProxy != nullptr)
    // {
    //     UVRadius = 0.5f * ResourceProxy->SizeUV;
    //     UVCenter = ResourceProxy->StartUV + UVRadius;
    // }

    // // Make a triangle fan in the area allotted
    // const int NumTris = 12;
    // TArray<FSlateVertex> Verts;
    // Verts.Reserve(NumTris*3);

    // // Center Vertex
    // Verts.AddZeroed();
    // {
    //     FSlateVertex& NewVert = Verts.Last();
    //     NewVert.Position[0] = Center.X;
    //     NewVert.Position[1] = Center.Y;
    //     NewVert.TexCoords[0] = UVCenter.X;
    //     NewVert.TexCoords[1] = UVCenter.Y;
    //     NewVert.TexCoords[2] = NewVert.TexCoords[3] = 1.0f;
    //     NewVert.Color = FColor::White;
    // }

    // for (int i = 0; i < NumTris; ++i)
    // {
    //     Verts.AddZeroed();
    //     {
    //         const float Angle = (2*PI*i) / NumTris;
    //         const FVector2D EdgeDirection(FMath::Cos(Angle), FMath::Sin(Angle));
    //         const FVector2D Edge(Radius*EdgeDirection);
    //         FSlateVertex& NewVert = Verts.Last();
    //         NewVert.Position[0] = Center.X + Edge.X;
    //         NewVert.Position[1] = Center.Y + Edge.Y;
    //         NewVert.TexCoords[0] = UVCenter.X + UVRadius.X*EdgeDirection.X;
    //         NewVert.TexCoords[1] = UVCenter.Y + UVRadius.Y*EdgeDirection.Y;
    //         NewVert.TexCoords[2] = NewVert.TexCoords[3] = 1.0f;
    //         NewVert.Color = FColor::White;
    //     }
    // }

    // TArray<SlateIndex> Indexes;
    // for (int i = 1; i <= NumTris; ++i)
    // {
    //     Indexes.Add(0);
    //     Indexes.Add(i);
    //     Indexes.Add( (i+1 > 12) ? (1) : (i+1) );
    // }

    // FSlateDrawElement::MakeCustomVerts(InParams.OutDrawElements, InParams.Layer, Handle, Verts, Indexes, nullptr, 0, 0);}
// }
