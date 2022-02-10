package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;
import unreal.GEngine;

class GameInstance extends unreal.UObject
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
		// HaxeMain.printToScreen("Hello from Haxe");
	}

	public function add(a: Int, b: Int)
	{
		var result = a + b;
		// HaxeMain.printToScreen(result);
		return result;
	}
	
	public function _p(inp:String)
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
