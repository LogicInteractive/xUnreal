package lib.types.geo;

import lib.types.Rectangle;
import lib.utils.MathUtils;

@:structInit
class PointQuad
{
	/////////////////////////////////////////////////////////////////////////////////////

	public var x1		: Float		= 0;
	public var y1		: Float		= 0;

	public var x2		: Float		= 0;
	public var y2		: Float		= 0;

	public var x3		: Float		= 0;
	public var y3		: Float		= 0;

	public var x4		: Float		= 0;
	public var y4		: Float		= 0;

	/////////////////////////////////////////////////////////////////////////////////////

	public inline function getBoundingBox():PointQuad
	{
        var left:Float = MathUtils.minMulti(x1, x2, x3, x4);
        var top:Float = MathUtils.minMulti(y1, y2, y3, y4);
        var right:Float = MathUtils.maxMulti(x1, x2, x3, x4);
        var bottom:Float = MathUtils.maxMulti(y1, y2, y3, y4);		

		return
		{
			x1: left,
			y1: top,
			x2: right,
			y2: top,
			x3: right,
			y3: bottom,
			x4: left,
			y4: bottom
		}
	}

	public inline function getBoundingRect():Rectangle
	{
        var left:Float = MathUtils.minMulti(x1, x2, x3, x4);
        var top:Float = MathUtils.minMulti(y1, y2, y3, y4);
        var right:Float = MathUtils.maxMulti(x1, x2, x3, x4);
        var bottom:Float = MathUtils.maxMulti(y1, y2, y3, y4);		

		return
		{
			x:left,
			y:top,
			width:right-left,
			height:bottom-top
		}
	}

	/////////////////////////////////////////////////////////////////////////////////////

}

