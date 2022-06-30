package unreal;

import cpp.Callable;
import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.Float32;
import cpp.Float64;
import cpp.Native;
import cpp.NativeString;
import cpp.Pointer;
import cpp.Star;
import unreal.GEngine;
import unreal.UExposed.AClass;
import unreal.UExposed.Bridge;
import unreal.types.Transform;
import unreal.types.Vector3;

@:nogenerate 
@:cppFileCode('
void _setActorLocation(void* p, Vector3* vec);
void _setActorRotation(void* p, Vector3* vec);
void _setActorScale3D(void* p, Vector3* vec);
void _getActorLocation(void* p, Vector3* vec);
void _getActorRotation(void* p, Vector3* vec);
void _getActorScale3D(void* p, Vector3* vec);
void _getActorTransform(void* p, Transform* tr);
void _setActorTransform(void* p, Transform* tr);
')
class Actor extends UObject implements AClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: Pointer<cpp.Void>;

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
	@:noCompletion var actorTransform				: Transform;

	public var primaryActorTick(get,null)			: ActorTickFunction;
	
	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	public function setOwner(owner:Star<cpp.Void>)
	{
		this.owner = Pointer.fromStar(owner);
	}

	public function new()
	{
		super();
	}

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
		actorTransform.Translation.x = x;
		actorTransform.Translation.y = y;
		actorTransform.Translation.z = z;
		untyped __global__._setActorLocation(owner.ptr,actorTransform.Translation.ref());
	}

	public function setActorRotation(x:Float,y:Float,z:Float)
	{
		actorTransform.Rotation.x = x;
		actorTransform.Rotation.y = y;
		actorTransform.Rotation.z = z;
		untyped __global__._setActorRotation(owner.ptr,actorTransform.Rotation.ref());
	}

	public function setActorScale3D(x:Float,y:Float,z:Float)
	{
		actorTransform.Scale3D.x = x;
		actorTransform.Scale3D.y = y;
		actorTransform.Scale3D.z = z;
		untyped __global__._setActorScale3D(owner.ptr,actorTransform.Scale3D.ref());
		@:bypassAccessor scale=(x+y+z)/3;			
	}

	public function getActorTransform():Transform
	{
		untyped __global__._getActorTransform(owner.ptr,actorTransform.ref());
		return actorTransform;
	}

	public function setActorTransform(t:Transform):Transform
	{
		@:bypassAccessor actorTransform = t;
		untyped __global__._setActorTransform(owner.ptr,actorTransform.ref());
		return actorTransform;
	}

	public function getActorLocation():Vector3
	{
		untyped __global__._getActorLocation(owner.ptr,actorTransform.Translation.ref());
		return actorTransform.Translation;
	}

	public function getActorRotation():Vector3
	{
		untyped __global__._getActorRotation(owner.ptr,actorTransform.Rotation.ref());
		return actorTransform.Rotation;
	}

	public function getActorScale3D():Vector3
	{
		untyped __global__._getActorScale3D(owner.ptr,actorTransform.Scale3D.ref());
		return actorTransform.Scale3D;
	}

	public function setActorTickEnabled(bEnabled:Bool)
	{
		primaryActorTick.setTickFunctionEnable(bEnabled);
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
	
	function get_primaryActorTick():ActorTickFunction
	{
		if (primaryActorTick==null)
			primaryActorTick = new ActorTickFunction(this);

		return primaryActorTick;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

@:cppFileCode('
void _setPrimaryActorTickCanEverTick(void* p, bool* b);
void _getPrimaryActorTickCanEverTick(void* p, bool* b);
void _getPrimaryActorTickStartWithTickEnabled(void* p, bool* b);
void _setPrimaryActorTickStartWithTickEnabled(void* p, bool* b);
void _setTickFunctionEnable(void* p, bool* b);
')
class ActorTickFunction
{
	/////////////////////////////////////////////////////////////////////////////////////

	var parent				: Actor;
	
	@:isVar public var bCanEverTick(get,set)						: Bool		= false;
    @:isVar public var bStartWithTickEnabled(get,set)				: Bool		= false;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new(parent:Actor)
	{
		this.parent = parent;
	}

	function get_bCanEverTick():Bool
	{
		var b:Bool = @:bypassAccessor bCanEverTick;
		untyped __global__._getPrimaryActorTickCanEverTick(cpp.Native.addressOf(parent.owner.ptr),cpp.Native.addressOf(b));
		return b;
	} 
	function set_bCanEverTick(value:Bool):Bool
	{
		var b:Bool = value;
		untyped __global__._setPrimaryActorTickCanEverTick(cpp.Native.addressOf(parent.owner.ptr),cpp.Native.addressOf(b));
		return bCanEverTick = b;
	} 

	function get_bStartWithTickEnabled():Bool
	{
		var b:Bool = @:bypassAccessor bStartWithTickEnabled;
		untyped __global__._getPrimaryActorTickStartWithTickEnabled(cpp.Native.addressOf(parent.owner.ptr),cpp.Native.addressOf(b));
		return b;
	} 
	function set_bStartWithTickEnabled(value:Bool):Bool
	{
		var b:Bool = value;
		untyped __global__._setPrimaryActorTickStartWithTickEnabled(cpp.Native.addressOf(parent.owner.ptr),cpp.Native.addressOf(b));
		return bStartWithTickEnabled = b;
	} 

	public function setTickFunctionEnable(value:Bool)
	{
		var b:Bool = value;
		untyped __global__._setTickFunctionEnable(cpp.Native.addressOf(parent.owner.ptr),cpp.Native.addressOf(b));
	} 

	/////////////////////////////////////////////////////////////////////////////////////
} 