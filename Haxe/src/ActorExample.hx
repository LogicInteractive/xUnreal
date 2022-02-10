package;

import unreal.*;

@:uclass(Blueprintable,Deprecated,meta=[BlueprintSpawnableComponent,ChildCanTick])
class ActorExample extends Actor
{
	/////////////////////////////////////////////////////////////////////////////////////

	@:uproperty(BlueprintReadOnly)
	public var value		: Float;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
		trace("Hello you actor you...");
	}

	override public function BeginPlay()
	{
	}

	override public function EndPlay()
	{
	}

	override public function Tick(deltaSeconds:Float)
	{
		super.Tick(deltaSeconds);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	// @:ufunction(BlueprintPure)
	public function getSomeValue():Float
	{
		trace("This is a pure function");
		return value;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

