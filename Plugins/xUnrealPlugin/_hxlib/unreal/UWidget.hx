package unreal;

import unreal.UExposed.Bridge;
import unreal.UExposed.UClass;

@:nogenerate
class UWidget extends UObjectBase implements UClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: cpp.Pointer<cpp.Void>;

	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	public function setOwner(owner:cpp.Star<cpp.Void>)
	{
		this.owner = cpp.Pointer.fromStar(owner);
		UObjectBase.setDelegateOwners(this);
	}

	public function new()
	{
		super();
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
