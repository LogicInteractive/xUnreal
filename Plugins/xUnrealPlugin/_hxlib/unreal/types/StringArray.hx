package unreal.types;

import cpp.CastCharStar;
import cpp.ConstPointer;
import cpp.Native;
import cpp.NativeArray;
import cpp.NativeString;
import lib.utils.ObjUtils;

@:include('./StringArray.h')
@:native("StringArray")
@:structAccess
extern class StringArray
{
	public var v_ptr		: cpp.Star<cpp.Void>;
	public var v_length		: Int;

	@:native('~StringArray')
	function free(): Void;

	@:native('new StringArray')
	static function alloc(): cpp.Star<StringArray>;

	@:native('StringArray')
	static function stackAlloc(): StringArray;

 	public inline function ref():cpp.Star<StringArray>
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

	public inline function toArray(freeMemory:Bool=true):Array<String>
	{	
		var r:Array<String> = [];
		var rptrs:Array<cpp.ConstPointer<cpp.Char>> = [];
		NativeArray.setUnmanagedData(rptrs,cast v_ptr, v_length);
		for (sptr in rptrs)
			r.push(NativeString.fromPointer(sptr));
		if (freeMemory)
			dispose();
		return r;	
	}

	public inline function toString(freeMemory:Bool=true):String
	{	
		return Std.string(toArray(freeMemory));
	}

	public static inline function create(array:Array<String>):StringArray
	{
		var h:StringArray = StringArray.stackAlloc();
		var chst:Array<cpp.ConstPointer<cpp.Char>> = [];
		for (s in array)
			chst.push(NativeString.c_str(s));
		h.v_ptr = cast cpp.Pointer.ofArray(chst);
		h.v_length = array.length;
		return h;	
	}
}


abstract AStringArray(StringArray) from StringArray to StringArray
{
	inline function new(i:StringArray)
	{
		this = i;
	}

	@:from
	static public function fromArray(i:Array<String>)
	{
		return new AStringArray(StringArray.create(i));
	}

	@:to
	public function toArray():Array<String>
	{
		return this.toArray(true);
	}
}