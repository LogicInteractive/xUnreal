package unreal.types;

import cpp.CastCharStar;
import lib.utils.MathUtils;

// @:using(unreal.types.Vector3)
@:include('./Vector3.h')
@:native("Vector3")
@:structAccess
extern class Vector3
{
	var x: Float;
	var y: Float;
	var z: Float;

	@:native('~Vector3')
	function free(): Void;

	@:native('new Vector3')
	static function alloc(): cpp.Star<Vector3>;

	@:native('Vector3')
	static function stackAlloc(): Vector3;

 	public inline function ref():cpp.Star<Vector3>
	{
		return cpp.Native.addressOf(this);
	}

	public inline function toString():String
	{	
		return Std.string('Vector3 [x:$x y:$y z:$]');
	}

	public static inline function create(x:Float,y:Float,z:Float):Vector3
	{
		var h:Vector3 = Vector3.stackAlloc();
		h.x = x;
		h.y = y;
		h.z = z;
		return h;	
	}	

	public static inline function random(maxX:Float=1.0,maxY:Float=1.0,maxZ:Float=1.0,minX:Float=0,minY:Float=0,minZ:Float=0):Vector3
	{
		return create(MathUtils.randomInRange(minX,maxX),MathUtils.randomInRange(minY,maxY),MathUtils.randomInRange(minZ,maxZ));
	}
}