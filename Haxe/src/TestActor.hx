package;

import unreal.*;
import unreal.UClassProperties.UClassProperties;
import unreal.UClassProperties.UClassPropertyMetadataSpecifiers;

@:uclass(Blueprintable,Deprecated,meta=[BlueprintSpawnableComponent,ChildCanTick])
class TestActor extends unreal.Actor
{
	/////////////////////////////////////////////////////////////////////////////////////

	@:uproperty(BlueprintReadOnly)
	public var speed		: Float;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	override public function BeginPlay()
	{
		// trace("Actor hello");
		y = (Math.random()*800)-400;
		x = (Math.random()*800)-400;
		speed = 0.1+(Math.random()*2);
	}

	override public function EndPlay()
	{
		// trace("actor goodbye");
	}

	override public function Tick(deltaSeconds:Float)
	{
		var time = unreal.World.getTimeSeconds();
		// setActorLocation(Math.sin(time*speed)*200,0,Math.cos(time*speed)*100+100);
		// setActorRotation(0,0,Math.sin(time*2*speed)*360);

		// y+=speed;
		z = Math.sin(time*speed*2.0)*200+200;
		// scale=Math.sin(time*speed*0.5)*360;
		// scale=2+Math.sin(time*speed*0.5);

		rotationZ+=speed;
		// rotationX=Math.sin(time*speed*0.5)*360;
		super.Tick(deltaSeconds);
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
