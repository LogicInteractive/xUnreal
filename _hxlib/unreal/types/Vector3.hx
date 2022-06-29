package unreal.types;

import cpp.CastCharStar;

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
 	// static inline public function ref(v:Vector3):cpp.Star<Vector3>
	// {
	// 	return cpp.Native.addressOf(v);
	// }
}