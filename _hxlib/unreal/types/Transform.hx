package unreal.types;

import cpp.CastCharStar;
import unreal.types.Vector3;

// @:using(unreal.types.Transform)
@:include('./Transform.h')
@:native("Transform")
@:structAccess
extern class Transform
{
	var Translation		: Vector3;
	var Rotation		: Vector3;
	var Scale3D			: Vector3;

	@:native('~Transform')
	function free(): Void;

	@:native('new Transform')
	static function alloc(): cpp.Star<Transform>;

	@:native('Transform')
	static function stackAlloc(): Transform;

 	public inline function ref():cpp.Star<unreal.types.Transform>
	{
		return cpp.Native.addressOf(this);
	}	
 	// static inline public function ref(tr:Transform):cpp.Star<unreal.types.Transform>
	// {
	// 	return cpp.Native.addressOf(tr);
	// }	
}