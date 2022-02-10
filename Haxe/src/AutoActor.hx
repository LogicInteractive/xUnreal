package;

import unreal.*;
import unreal.World;

// @:build(UEHX.buildTemplates("Actor"))
@:uclass(Blueprintable,Deprecated,meta=[BlueprintSpawnableComponent,ChildCanTick])
class AutoActor extends Actor
{
	/////////////////////////////////////////////////////////////////////////////////////

	@:uproperty(BlueprintReadOnly)
	public var value		: Float;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();

		trace("Hello doggy!!");
	}

	override public function BeginPlay()
	{
	}

	override public function EndPlay()
	{
	}

	override public function Tick(deltaSeconds:Float)
	{
		// scale = 2.0 + Math.sin(World.getTimeSeconds());

		var time = unreal.World.getTimeSeconds();
		x = Math.sin(time*5.0)*100+100;

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

