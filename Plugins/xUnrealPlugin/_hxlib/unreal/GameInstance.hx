package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;
import cpp.Pointer;
import lib.utils.ObjUtils;
import unreal.GEngine;
import unreal.UExposed.Bridge;
import unreal.UExposed.UClass;
import unreal.types.DynamicWrapper;

@:nogenerate 
class GameInstance extends UObjectBase implements UClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: Pointer<cpp.Void>;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	@:noCompletion
	public function setOwner(owner:cpp.Star<cpp.Void>)
	{
		this.owner = Pointer.fromStar(owner);
		UObjectBase.setDelegateOwners(this);
	}

	public function Init()
	{
	}

	public function Shutdown()
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
