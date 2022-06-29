package unreal;

import unreal.UExposed.Bridge;
import unreal.UExposed.UClass;

@:nogenerate
class UWidget extends unreal.UObject implements UClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: cpp.Pointer<cpp.Void>;

	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	public function setOwner(owner:cpp.Star<cpp.Void>)
	{
		this.owner = cpp.Pointer.fromStar(owner);
	}

	public function new()
	{
		super();
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
