package unreal.types;

import cpp.CastCharStar;
import cpp.NativeArray;
import cpp.NativeString;
import lib.utils.ObjUtils;

@:include('./IntArray.h')
@:native("IntArray")
@:structAccess
extern class IntArray
{
	public var v_ptr		: cpp.Star<cpp.Void>;
	public var v_length		: Int;

	@:native('~IntArray')
	function free(): Void;

	@:native('new IntArray')
	static function alloc(): cpp.Star<IntArray>;

	@:native('IntArray')
	static function stackAlloc(): IntArray;

 	public inline function ref():cpp.Star<IntArray>
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

	public inline function toArray(freeMemory:Bool=true):Array<Int>
	{	
		var r:Array<Int> = [];
		NativeArray.setUnmanagedData(r,cast v_ptr, v_length);
		if (freeMemory)
			dispose();
		return r;	
	}

	public inline function toString(freeMemory:Bool=true):String
	{	
		return Std.string(toArray(freeMemory));
	}

	public static inline function create(array:Array<Int>):IntArray
	{
		var h:IntArray = IntArray.stackAlloc();
		h.v_ptr = cast cpp.Pointer.ofArray(array);
		h.v_length = array.length;
		return h;	
	}
}

abstract AIntArray(IntArray) from IntArray to IntArray
{
	inline function new(i:IntArray)
	{
		this = i;
	}

	@:from
	static public function fromArray(i:Array<Int>)
	{
		return new AIntArray(IntArray.create(i));
	}

	@:to
	public function toArray():Array<Int>
	{
		return this.toArray(true);
	}
}