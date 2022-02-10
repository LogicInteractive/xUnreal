package;

import unreal.*;

@:keep
class TestBPFuncLib extends unreal.BlueprintFunctionLibrary
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	@:ufunction(BlueprintCallable, BlueprintPure, Category="My testBP lib")
	static public function whatsup():String
	{
		return "nooooo....";
	}	

	// @:ufunction(BlueprintCallable, Category="My testBP lib")
	// static public function trace(input:String):String
	// {
	// 	trace(input);
	// 	return "";
	// }	

	/////////////////////////////////////////////////////////////////////////////////////
}

// ="My testBP lib"