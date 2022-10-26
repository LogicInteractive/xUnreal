package unreal.types;

import cpp.CastCharStar;
import cpp.NativeString;

@:include('./DynamicWrapper.h')
@:native("DynamicWrapper")
@:structAccess
extern class DynamicWrapper
{
	public var v_typeCode 	: Int;
	public var v_type 		: cpp.Star<cpp.Char>;
	public var v_float 		: Float;
	public var v_int 		: Int;
	public var v_bool 		: Bool;
	public var v_str 		: cpp.Star<cpp.Char>;
	public var v_dynamic	: Dynamic;

	@:native('~DynamicWrapper')
	function free(): Void;

	@:native('new DynamicWrapper')
	static function alloc(): cpp.Star<DynamicWrapper>;

	@:native('DynamicWrapper')
	static function stackAlloc(): DynamicWrapper;

 	public inline function ref():cpp.Star<DynamicWrapper>
	{
		return cpp.Native.addressOf(this);
	}

	public static inline function create(fromValue:Dynamic):DynamicWrapper
	{
		var w:DynamicWrapper = DynamicWrapper.stackAlloc();
		if (fromValue is String)
		{
			w.v_type = cast NativeString.c_str("string");
			w.v_str = cast NativeString.c_str(Std.string(fromValue));
			w.v_typeCode = 1;
		}
		else if (fromValue is Float)
		{
			w.v_type = cast NativeString.c_str("float");
			w.v_float = (fromValue:Float);
			w.v_typeCode = 2;
		}
		else if (fromValue is Int)
		{
			w.v_type = cast NativeString.c_str("int");
			w.v_int = (fromValue:Int);
			w.v_typeCode = 3;
		}
		else if (fromValue is Bool)
		{
			w.v_type = cast NativeString.c_str("bool");
			w.v_bool = (fromValue:Bool);
			w.v_typeCode = 4;
		}
		else
		{
			w.v_type = cast NativeString.c_str("string");
			w.v_str = cast NativeString.c_str(Std.string(fromValue));
			w.v_typeCode = 1;
		}
		return w;	
	}

 	public inline function getType():String
	{
		if (v_type==null)
			return null;
		else
			return NativeString.fromPointer(cast v_type);
	}

 	public inline function getValue():Dynamic
	{
		return switch (v_typeCode)
		{
			case 1		: NativeString.fromPointer(cast v_str);
			case 2		: v_float;
			case 3		: v_int;
			case 4		: v_bool;
			case 5		: v_dynamic;
			case _		: null;
		}
	}
}