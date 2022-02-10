package unreal;

import cpp.Callable;
import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.Float32;
import cpp.Float64;
import cpp.NativeString;
import unreal.GEngine;
import unreal.types.Transform;
import unreal.types.Vector3;

@:nogenerate 
@:autoBuild(HxUnreal.buildTemplates("AActor"))
class Actor extends UObject
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: cpp.Star<cpp.Void>;

	@:isVar public var x(get,set)					: Float;
	@:isVar public var y(get,set)					: Float;
	@:isVar public var z(get,set)					: Float;

	@:isVar public var rotationX(get,set)			: Float;
	@:isVar public var rotationY(get,set)			: Float;
	@:isVar public var rotationZ(get,set)			: Float;

	@:isVar public var scaleX(get,set)				: Float;
	@:isVar public var scaleY(get,set)				: Float;
	@:isVar public var scaleZ(get,set)				: Float;
	public var scale(default,set)					: Float;

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

	@:uproperty(name="test",mode="test, not working yet")
	public function BeginPlay()
	{
	
	}

	public function EndPlay()
	{
	}

	public function Tick(deltaSeconds:Float)
	{
	}

	public function setActorLocation(x:Float,y:Float,z:Float)
	{
		UeExt._setActorLocation(this.owner,x,y,z);

		actorTransform.Translation.x = x;
		actorTransform.Translation.y = y;
		actorTransform.Translation.z = z;
	}

	public function setActorRotation(x:Float,y:Float,z:Float)
	{
		UeExt._setActorRotation(this.owner,x,y,z);

		actorTransform.Rotation.x = x;
		actorTransform.Rotation.y = y;
		actorTransform.Rotation.z = z;
	}

	public function setActorScale3D(x:Float,y:Float,z:Float)
	{
		UeExt._setActorScale3D(this.owner,x,y,z);

		actorTransform.Scale3D.x = x;
		actorTransform.Scale3D.y = y;
		actorTransform.Scale3D.z = z;
		@:bypassAccessor scale=(x+y+z)/3;			
	}

	public function getActorLocation():Vector3
	{
		return actorTransform.Translation;
	}

	public function getActorRotation():Vector3
	{
		return actorTransform.Rotation;
	}

	public function getActorScale3D():Vector3
	{
		return actorTransform.Scale3D;
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
	function get_x():Float { return actorTransform.Translation.x; }
	function set_x(value:Float):Float
	{
		setActorLocation(value,actorTransform.Translation.y,actorTransform.Translation.z);
		return x=value;
	}

	function get_y():Float { return actorTransform.Translation.y; }
	function set_y(value:Float):Float
	{
		setActorLocation(actorTransform.Translation.x,value,actorTransform.Translation.z);
		return y=value;
	}

	function get_z():Float { return actorTransform.Translation.z; }
	function set_z(value:Float):Float
	{
		setActorLocation(actorTransform.Translation.x,actorTransform.Translation.y,value);
		return z=value;
	}
	
	function get_rotationX():Float { return actorTransform.Rotation.x; }
	function set_rotationX(value:Float):Float
	{
		setActorRotation(value,actorTransform.Translation.y,actorTransform.Rotation.z);
		return rotationX=value;
	}

	function get_rotationY():Float { return actorTransform.Rotation.y; }
	function set_rotationY(value:Float):Float
	{
		setActorRotation(actorTransform.Translation.x,value,actorTransform.Rotation.z);
		return rotationY=value;
	}

	function get_rotationZ():Float { return actorTransform.Rotation.z; }
	function set_rotationZ(value:Float):Float
	{
		setActorRotation(actorTransform.Rotation.x,actorTransform.Rotation.y,value);
		return rotationZ=value;
	}

	function get_scaleX():Float { return actorTransform.Scale3D.x; }
	function set_scaleX(value:Float):Float
	{
		setActorScale3D(value,actorTransform.Scale3D.y,actorTransform.Scale3D.z);
		return scaleX=value;
	}

	function get_scaleY():Float { return actorTransform.Scale3D.y; }
	function set_scaleY(value:Float):Float
	{
		setActorScale3D(actorTransform.Scale3D.x,value,actorTransform.Scale3D.z);
		return scaleY=value;
	}

	function get_scaleZ():Float { return actorTransform.Scale3D.x; }
	function set_scaleZ(value:Float):Float
	{
		setActorScale3D(actorTransform.Scale3D.x,actorTransform.Scale3D.y,value);
		return scaleZ=value;
	}
	
	function set_scale(value:Float):Float
	{
		setActorScale3D(value,value,value);
		return scale=value;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion var actorTransform:Transform;
	@:noCompletion
	public function setActorTransform_inp(transform:Transform)
	{
		actorTransform = transform;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

// typedef Float3Callback = Callable<(p:cpp.Star<cpp.Void>,x:Float,y:Float,z:Float)->Void>;
