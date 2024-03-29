package unreal;

import unreal.UExposed.Bridge;
import unreal.UExposed.UClass;

@:nogenerate
class BlueprintAsyncActionBase extends UObjectBase implements UClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: cpp.Star<cpp.Void>;
	
	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	public function setOwner(owner:cpp.Star<cpp.Void>)
	{
		this.owner = owner;
	}

	public function new()
	{
		super();
	}

	public function dispose()
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
