package lib.utils;

import lib.FastFloat;
import lib.types.math.FastVector2;

class FastVector2Tools
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function multiplyScalar(a:FastVector2, v:FastFloat)
	{
	    return new FastVector2(a.x * v, a.y * v);
	}

	static public inline function clone(vec2:FastVector2)
	{
		return new FastVector2(vec2.x, vec2.y);
	}

	static public inline function copyFrom(vec2:FastVector2,other:FastVector2)
	{
		vec2.x = other.x;
		vec2.y = other.y;
	}

	static public inline function cross(vec2:FastVector2,other:FastVector2)
	{
		return vec2.x * other.y - vec2.y * other.x;
	}

	static public inline function subtract(a:FastVector2, b:FastVector2)
	{
	    return new FastVector2(a.x - b.x, a.y - b.y);
	}

	static public inline function set(vec2:FastVector2, x:FastFloat, y:FastFloat)
	{
		vec2.x = x;
		vec2.y = y;
	}

	/////////////////////////////////////////////////////////////////////////////////////

}