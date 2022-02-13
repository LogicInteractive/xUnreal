package;

import unreal.*;
import unreal.UeExt;
import unreal.UserWidget;

@:keep
class TestUserWidget extends unreal.UserWidget
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	override public function NativeConstruct()
	{
		trace("Hello widget!! ================= >> ");

		// GEngineExt.AddOnScreenDebugMessage();
		// GEngineExt.AddOnScreenDebugMessage(1, 20.0, null, cast "Hello crazy" ,true, null);
	}	

	@:ufunction(BlueprintPure)
	public function getSomeText():String
	{
		return 'The time is : ${Math.random()}';
	}

	@:ufunction(BlueprintCallable)
	public function getSomeInt():Int
	{
		return Std.int(127*Math.random());
	}

	@:ufunction(BlueprintCallable)
	public function getSomeFloat():Float
	{
		return Math.random();
	}

	@:ufunction(BlueprintPure,CallInEditor)
	public function getSomeBool():Bool
	{
		return Math.random()>0.5;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
