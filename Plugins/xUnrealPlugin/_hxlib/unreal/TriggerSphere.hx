package unreal;

import lib.utils.ObjUtils;
import unreal.Actor.ActorPtr;
import unreal.UExposed.AClass;
import unreal.UExposed.Bridge;
import unreal.types.DynamicWrapper;

@:nogenerate 
@:cppFileCode('
// void _TriggerCurrentOverlaps(void* owner);
')
class TriggerSphere extends UObjectBase implements AClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner					: cpp.Pointer<cpp.Void>;
	var overlappedNamedActors	: Map<String, ActorPtr>		= [];	

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	public function setOwner(owner:cpp.Star<cpp.Void>)
	{
		this.owner = cpp.Pointer.fromStar(owner);
		UObjectBase.setDelegateOwners(this);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	public function BeginPlay()
	{
		trace("hello");
	}

	public function EndPlay()
	{
		trace("bi bi");
	}

	public function Tick(deltaSeconds:Float)
	{
	}
	
	public function OnOverlapBegin(overlappedActor:ActorPtr, overlappedActorName:String)
	{
	}
	
	public function OnOverlapEnd(otherActor:ActorPtr, overlappedActorName:String)
	{
	}

	@:noCompletion
	public function OnOverlapBeginInternal(overlappedActor:ActorPtr, overlappedActorName:String)
	{
		if (overlappedActorName!=null && overlappedActorName!="")
			overlappedNamedActors.set(overlappedActorName,overlappedActor);
		OnOverlapBegin(overlappedActor,overlappedActorName);
	}

	@:noCompletion
	public function OnOverlapEndInternal(otherActor:ActorPtr, overlappedActorName:String)
	{
		OnOverlapEnd(otherActor,overlappedActorName);
		if (overlappedActorName!=null && overlappedActorName!="" && overlappedNamedActors.exists(overlappedActorName))
			overlappedNamedActors.remove(overlappedActorName);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	public function isHasNamedOverlapActor(name:String):Bool
	{
		return overlappedNamedActors.exists(name);
	}

	// public function triggerCurrentOverlaps()
	// {
	// 	untyped __global__._TriggerCurrentOverlaps(owner.ptr);
	// }

	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	public function incomingDelegate(delegateName:String,numParams:Int=0,param1:cpp.Star<DynamicWrapper>,param2:cpp.Star<DynamicWrapper>,param3:cpp.Star<DynamicWrapper>)
	{
		UObjectBase.processIncomingDelegate(this, 
		{
			delegateName:delegateName,
			numParams:numParams,
			param1:param1,
			param2:param2,
			param3:param3
		});
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
