package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;
import cpp.Pointer;
import unreal.GEngine;
import unreal.UExposed.Bridge;
import unreal.UExposed.UClass;
import unreal.UObject;

@:nogenerate 
class GameInstance extends UObject implements UClass implements Bridge 
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
	}

	public function Init()
	{
	}

	public function Shutdown()
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
