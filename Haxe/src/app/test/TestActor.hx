package app.test;

import unreal.Actor;

class TestActor extends Actor
{
	/////////////////////////////////////////////////////////////////////////////////////

	@:uproperty(EditAnywhere, BlueprintReadWrite)
	public var testid				: Int				= -1;

	/////////////////////////////////////////////////////////////////////////////////////

    public function new()
	{
		super();
    }

	override public function BeginPlay()
	{
		super.BeginPlay();
	}

	override public function EndPlay()
	{
		super.EndPlay();
	}

	override public function Tick(deltaSeconds:Float)
	{
		super.Tick(deltaSeconds);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function doSomething(inp:String):String
	{
		trace(inp);
		return "hello";
	}	

	/////////////////////////////////////////////////////////////////////////////////////
}

