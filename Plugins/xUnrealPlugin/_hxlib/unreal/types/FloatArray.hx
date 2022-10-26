package unreal.types;

import cpp.CastCharStar;
import cpp.NativeArray;
import cpp.NativeString;
import lib.utils.ObjUtils;

@:include('./FloatArray.h')
@:native("FloatArray")
@:structAccess
extern class FloatArray
{
	public var v_ptr		: cpp.Star<cpp.Void>;
	public var v_length		: Int;

	@:native('~FloatArray')
	function free(): Void;

	@:native('new FloatArray')
	static function alloc(): cpp.Star<FloatArray>;

	@:native('FloatArray')
	static function stackAlloc(): FloatArray;

 	public inline function ref():cpp.Star<FloatArray>
	{
		return cpp.Native.addressOf(this);
	}

	@:functionCode('delete [] v_ptr;')
	inline function freeCArray():Void { }

	public inline function dispose():Void
	{
		freeCArray();
		free();
	}

	public inline function toArray(freeMemory:Bool=true):Array<Float>
	{	
		var r:Array<Float> = [];
		NativeArray.setUnmanagedData(r,cast v_ptr, v_length);
		if (freeMemory)
			dispose();
		return r;	
	}

	public inline function toString(freeMemory:Bool=true):String
	{	
		return Std.string(toArray(freeMemory));
	}

	public static inline function create(array:Array<Float>):FloatArray
	{
		var h:FloatArray = FloatArray.stackAlloc();
		h.v_ptr = cast cpp.Pointer.ofArray(array);
		h.v_length = array.length;
		return h;	
	}

}