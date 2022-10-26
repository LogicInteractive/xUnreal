package lib.types;

typedef Point = { x:Float, y:Float };

typedef IntPoint =
{	
	var x:Int;
	var y:Int;
}

typedef DoublePoint =
{	
	var x1:Float;
	var y1:Float;
	var x2:Float;
	var y2:Float;
}

@:structInit
class Point2D
{
	public var length(get, never):Float;
	public var x:Float;
	public var y:Float;

	public function new(x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
	}

	public function add(v:Point2D):Point2D
	{
		return new Point2D(v.x + x, v.y + y);
	}

	public function clone():Point2D
	{
		return new Point2D(x, y);
	}

	public function copyFrom(sourcePoint:Point2D):Void
	{
		x = sourcePoint.x;
		y = sourcePoint.y;
	}

	public static function distance(pt1:Point2D, pt2:Point2D):Float
	{
		var dx = pt1.x - pt2.x;
		var dy = pt1.y - pt2.y;
		return Math.sqrt(dx * dx + dy * dy);
	}

	public function equals(toCompare:Point2D):Bool
	{
		return toCompare != null && toCompare.x == x && toCompare.y == y;
	}

	public static function interpolate(pt1:Point2D, pt2:Point2D, f:Float):Point2D
	{
		return new Point2D(pt2.x + f * (pt1.x - pt2.x), pt2.y + f * (pt1.y - pt2.y));
	}

	public function normalize(thickness:Float):Void
	{
		if (x == 0 && y == 0)
		{
			return;
		}
		else
		{
			var norm = thickness / Math.sqrt(x * x + y * y);
			x *= norm;
			y *= norm;
		}
	}

	public function offset(dx:Float, dy:Float):Void
	{
		x += dx;
		y += dy;
	}

	public static function polar(len:Float, angle:Float):Point2D
	{
		return new Point2D(len * Math.cos(angle), len * Math.sin(angle));
	}

	public function setTo(xa:Float, ya:Float):Void
	{
		x = xa;
		y = ya;
	}

	public function subtract(v:Point2D):Point2D
	{
		return new Point2D(x - v.x, y - v.y);
	}

	public function toString():String
	{
		return '(x=$x, y=$y)';
	}

	// Getters & Setters
	@:noCompletion private function get_length():Float
	{
		return Math.sqrt(x * x + y * y);
	}
}