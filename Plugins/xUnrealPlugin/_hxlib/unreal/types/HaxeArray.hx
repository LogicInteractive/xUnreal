package unreal.types;

import cpp.CastCharStar;
import cpp.NativeString;
import lib.utils.ObjUtils;

@:include('./HaxeArray.h')
@:native("HaxeArray")
@:structAccess
extern class HaxeArray
{
	public var v_typeCode 	: Int;
	public var v_ptr		: cpp.Star<cpp.Void>;
	public var v_float 		: Float;
	public var v_length		: Int;

	@:native('~HaxeArray')
	function free(): Void;

	@:native('new HaxeArray')
	static function alloc(): cpp.Star<HaxeArray>;

	@:native('HaxeArray')
	static function stackAlloc(): HaxeArray;

 	public inline function ref():cpp.Star<HaxeArray>
	{
		return cpp.Native.addressOf(this);
	}

	public static inline function fromIntArray<T>(array:Array<T>):HaxeArray
	{
		var h:HaxeArray = HaxeArray.stackAlloc();
		trace(ObjUtils.getName(array));

	
		// h.v_ptr = cast cpp.Pointer.ofArray(array);
		// h.v_length = array.length;
		// h.v_typeCode = 2;
		return h;	
	}

}