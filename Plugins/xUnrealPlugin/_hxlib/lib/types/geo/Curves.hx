package lib.types.geo;

import lib.utils.PointUtils.Point;

class Curves
{
    public function new()
	{
        
    }
}

class LinearPosition
{
	/////////////////////////////////////////////////////////////////////////////////////

	var x0: Float;
	var x1: Float;
	var y0: Float;
	var y1: Float;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new (x0:Float, x1:Float, y0:Float, y1:Float)
	{
		this.x0 = x0;
		this.x1 = x1;
		this.y0 = y0;
		this.y1 = y1;
	}

	public function getTotalLength():Float
	{
		return Math.sqrt(Math.pow(this.x0 - this.x1, 2) + Math.pow(this.y0 - this.y1, 2));
	}

	public function getPointAtLength(pos:Float):Point
	{
		var fraction = pos / Math.sqrt(Math.pow(this.x0 - this.x1, 2) + Math.pow(this.y0 - this.y1, 2));
		fraction = Math.isNaN(fraction) ? 1 : fraction;
		final newDeltaX = (this.x1 - this.x0) * fraction;
		final newDeltaY = (this.y1 - this.y0) * fraction;

		return { x: this.x0 + newDeltaX, y: this.y0 + newDeltaY };
	}

	public function getTangentAtLength(_:Float):Point
	{
    	final module = Math.sqrt( (this.x1 - this.x0) * (this.x1 - this.x0) + (this.y1 - this.y0) * (this.y1 - this.y0) );
    	return { x: (this.x1 - this.x0) / module, y: (this.y1 - this.y0) / module };
	}

	public function getPropertiesAtLength(pos:Float):PointProperties
	{
		final point = this.getPointAtLength(pos);
		final tangent = this.getTangentAtLength(pos);
		return { x: point.x, y: point.y, tangentX: tangent.x, tangentY: tangent.y };
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
typedef PointProperties =
{
	x:			Float,
	y:			Float,
	tangentX:	Float,
	tangentY:	Float
}