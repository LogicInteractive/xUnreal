package unreal;

import cpp.NativeString;
import haxe.Constraints.Function;
import lib.utils.ObjUtils;
import unreal.UExposed.Bridge;
import unreal.UExposed.UClass;
import unreal.UExposed;
import unreal.types.DynamicWrapper;

@:nogenerate
class Object extends UObjectBase implements UClass implements Bridge
{
	
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: cpp.Pointer<cpp.Void>;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	@:noCompletion
	public function setOwner(owner:cpp.Star<cpp.Void>)
	{
		this.owner = cpp.Pointer.fromStar(owner);
		UObjectBase.setDelegateOwners(this);
	}

	@:expose
	public function destructor()
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
