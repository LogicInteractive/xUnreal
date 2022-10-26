package unreal.types;

import cpp.CastCharStar;
import lib.utils.MathUtils;

@:include('./Vector2D.h')
@:native("Vector2D")
@:structAccess
extern class Vector2D
{
	var x: Float;
	var y: Float;

	@:native('~Vector2D')
	function free(): Void;

	@:native('new Vector2D')
	static function alloc(): cpp.Star<Vector2D>;

	@:native('Vector2D')
	static function stackAlloc(): Vector2D;

 	public inline function ref():cpp.Star<Vector2D>
	{
		return cpp.Native.addressOf(this);
	}

	public inline function toString():String
	{	
		return Std.string('Vector2D [x:$x y:$y]');
	}	

	public static inline function create(x:Float,y:Float):Vector2D
	{
		var h:Vector2D = Vector2D.stackAlloc();
		h.x = x;
		h.y = y;
		return h;	
	}	

	public static inline function random(maxX:Float=1.0,maxY:Float=1.0,minX:Float=0,minY:Float=0):Vector2D
	{
		return create(MathUtils.randomInRange(minX,maxX),MathUtils.randomInRange(minY,maxY));
	}	
}