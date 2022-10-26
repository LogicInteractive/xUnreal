package unreal;

import lib.utils.ObjUtils;
import unreal.UExposed.AClass;
import unreal.UExposed.Bridge;
import unreal.types.DynamicWrapper;

@:nogenerate 
class GameModeBase extends UObjectBase implements AClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: cpp.Pointer<cpp.Void>;

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
	
	}

	public function EndPlay()
	{
	}

	public function Tick(deltaSeconds:Float)
	{
	}

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
