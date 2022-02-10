package unreal.types;

import cpp.CastCharStar;
import unreal.types.Vector3;

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
}