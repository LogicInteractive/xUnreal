package lib.graphics;

import lib.graphics.GraphicsPathCommand;
import lib.types.Point2D.Point;
import lib.types.math.Float2;
import lib.utils.MathUtils;

class ShapePoints
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public function arc(cx:Float, cy:Float, radius:Float, sAngle:Float, eAngle:Float, ccw: Bool = false, segments: Int = 0):Array<Point>
	{
		var strength:Float = 1;

		sAngle = MathUtils.degreesToRadians(sAngle-90);
		eAngle = MathUtils.degreesToRadians(eAngle-90);

		sAngle = sAngle % (Math.PI * 2);
		eAngle = eAngle % (Math.PI * 2);

		if (ccw)
		{
			if (eAngle > sAngle)
				eAngle -= Math.PI * 2;
		}
		else if (eAngle < sAngle)
			eAngle += Math.PI * 2;

		// radius += strength / 2;
		if (segments <= 0)
			segments = Math.floor(10 * Math.sqrt(radius));

		var theta = (eAngle - sAngle) / segments;
		var c = Math.cos(theta);
		var s = Math.sin(theta);

		var x = Math.cos(sAngle) * radius;
		var y = Math.sin(sAngle) * radius;

		var pOut:Array<Point> = [];

		for (n in 0...segments)
		{
			var px = x + cx;
			var py = y + cy;

			var t = x;
			x = c * x - s * y;
			y = c * y + s * t;

			pOut.push({x:x+cx,y:y+cy});
			// pOut.push({x:px,y:py});
		}

		return pOut;
	}
	
	static public function arc2(cx:Float, cy:Float, radius:Float, sAngle:Float, eAngle:Float, ccw: Bool = false, segments: Int = 0):Array<Float>
	{
		var a2:Array<Float> = [];
		for (p in arc(cx,cy,radius,sAngle,eAngle,ccw,segments))
		{
			a2.push(p.x);
			a2.push(p.y);
		}		
		return a2;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	// To find orientation of ordered triplet (p, q, r).
	// The function returns following values
	// 0 --> p, q and r are collinear
	// 1 --> Clockwise
	// 2 --> Counterclockwise
	static inline function cHullorientation(p:Point,q:Point,r:Point):Int
	{
		var val:Float = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
	
		if (val == 0) 
			return 0; // collinear
		else 
			return (val > 0)? 1: 2; // clock or counterclock wise
	}

	static public function convexHull(points:Array<Point>):Array<Point>
	{
		if (points==null)
			return null;

		var n = points.length;

		// There must be at least 3 points
		if (n < 3) 
			return null;		

		var hull:Array<Point> = [];

		// Find the leftmost point
		var l = 0;
		for (i in 0...n)
			if (points[i].x < points[l].x)
				l = i;

		// Start from leftmost point, keep moving
		// counterclockwise until reach the start point
		// again. This loop runs O(h) times where h is
		// number of points in result or output.
		var p:Int = l;
		var q:Int = 0;

		do
		{
			// Add current point to result
			hull.push(points[p]);
	
			// Search for a point 'q' such that
			// orientation(p, q, x) is counterclockwise
			// for all points 'x'. The idea is to keep
			// track of last visited most counterclock-
			// wise point in q. If any point 'i' is more
			// counterclock-wise than q, then update q.
			q = (p + 1) % n;
			
			for (i in 0...n)
			{
				// If i is more counterclockwise than
				// current q, then update q
				if (cHullorientation(points[p], points[i], points[q]) == 2)
					q = i;
			}
		
			// Now q is the most counterclockwise with
			// respect to p. Set p as q for next iteration,
			// so that q is added to result 'hull'
			p = q;
	
		} 
		while (p != l); // While we don't come to first point

		return hull;				
	}

	/////////////////////////////////////////////////////////////////////////////////////

	/**
	 * Points in a ellipse.
	 * @param	segments (optional) The amount of point that should be used to generate the ellipse.
	 */
	public static function ellipse(cx:Float, cy:Float, width:Float, height:Float, rotationAngle:Float=0, segments:Int=0):Array<Point>
	{
		var radiusX = height*0.5;
		var radiusY = width*0.5;

		if (segments <= 0)
			segments = Math.floor(10 * Math.sqrt((radiusX+radiusY)*0.5));

		var x = 0.0;
		var y = 0.0;

		var cp:Array<Point> = [];

		var i=0*Math.PI;
		while (i < 2 * Math.PI)
		{
			var x = cx - (radiusX * Math.sin(i)) * Math.sin(rotationAngle * Math.PI) + (radiusY * Math.cos(i)) * Math.cos(rotationAngle * Math.PI);
			var y = cy + (radiusY * Math.cos(i)) * Math.sin(rotationAngle * Math.PI) + (radiusX * Math.sin(i)) * Math.cos(rotationAngle * Math.PI);
			cp.push({x:x, y:y});
			i += 0.05;
		}
		return cp;
	}

	/**
	 * Points in a circle.
	 * @param	segments (optional) The amount of point that should be used to generate the circle.
	 */
	public static function circle(cx: Float, cy: Float, radius: Float, segments: Int = 0):Array<Point>
	{
		// radius += strength / 2;

		if (segments <= 0)
			segments = Math.floor(10 * Math.sqrt(radius));

		var theta = 2 * Math.PI / segments;
		var c = Math.cos(theta);
		var s = Math.sin(theta);

		var x = radius;
		var y = 0.0;

		var cp:Array<Point> = [];
		for (n in 0...segments)
		{
			// var px = x + cx;
			// var py = y + cy;

			var t = x;
			x = c * x - s * y;
			y = c * y + s * t;
			cp.push({x:x+cx, y:y+cy});
		}
		cp.push({x:cp[0].x, y:cp[0].y});
		return cp;
	}

	/**
	 * Points in a circle.
	 * @param	segments (optional) The amount of point that should be used to generate the circle.
	 */
	public static function circle2(cx: Float, cy: Float, radius: Float, segments: Int = 0):Array<Float>
	{
		// radius += strength / 2;

		if (segments <= 0)
			segments = Math.floor(10 * Math.sqrt(radius));

		var theta = 2 * Math.PI / segments;
		var c = Math.cos(theta);
		var s = Math.sin(theta);

		var x = radius;
		var y = 0.0;

		var cp:Array<Float> = [];
		for (n in 0...segments)
		{
			// var px = x + cx;
			// var py = y + cy;

			var t = x;
			x = c * x - s * y;
			y = c * y + s * t;
			cp.push(x+cx);
			cp.push(y+cy);
		}
		cp.push(cp[0]);
		cp.push(cp[1]);
		return cp;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function roundedRect(x:Float, y:Float, width:Float, height:Float, radius:Dynamic=5.0, segments:Int=15):Array<Point>
	{
		var rad1:Float = 5.0;
		var rad2:Float = 5.0;
		var rad3:Float = 5.0;
		var rad4:Float = 5.0;
		if (radius!=null)
		{
			if (Std.isOfType(radius,Float))
				rad1 = rad2 = rad3 = rad4 = radius;
			else if (Std.isOfType(radius,Array))
			{
				if (radius.length==4)
				{
					rad1=radius[0];
					rad2=radius[1];
					rad3=radius[2];
					rad4=radius[3];
				}
			}
		}

		if (width>height)
			rad1 = rad2 = rad3 = rad4 = MathUtils.clamp(rad2>rad4?rad2:rad4,0,height*0.5);
		else
			rad1 = rad2 = rad3 = rad4 = MathUtils.clamp(rad1>rad3?rad1:rad3,0,width*0.5);

		var points:Array<Point> = [];
		points.push({x:x+radius,y:y});
		for (p in quadraticCurvePoints(x + width - rad2, y, x + width, y, x + width, y + rad2,segments))
			points.push(p);
		for (p in quadraticCurvePoints(x + width, y + height - rad3, x + width, y + height, x + width - rad3, y + height,segments))
			points.push(p);
		for (p in quadraticCurvePoints(x + rad4, y + height, x, y + height, x, y + height - rad4,segments))
			points.push(p);
		for (p in quadraticCurvePoints(x, y + rad1, x, y, x + rad1, y,segments))
			points.push(p);

		return points;
	}

	static public function roundedRect2(x:Float, y:Float, width:Float, height:Float, radius:Dynamic=5.0, segments:Int=15):Array<Float>
	{
		var rrf:Array<Float> = [];
		for (rrp in roundedRect(x,y,width,height,radius,segments))
		{
			rrf.push(rrp.x);
			rrf.push(rrp.y);
		}
		return rrf;
	}	

	/////////////////////////////////////////////////////////////////////////////////////

/**
	 * Makes points for a quadratic curve.
	 * @param	x1			X start.
	 * @param	y1			Y start.
	 * @param	x2			X control point, used to determine the curve.
	 * @param	y2			Y control point, used to determine the curve.
	 * @param	x3			X finish.
	 * @param	y3			Y finish.
	 * @param	segments	Increasing will smooth the curve but takes longer to render. Must be a value greater than zero.
	 */
	static public function quadraticCurvePoints(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, segments:Int = 25):Array<Point>
	{
		var points:Array<Point> = [];
		points.push({x:x1,y:y1});

		var deltaT:Float = 1 / segments;

		for (segment in 1...segments)
		{
			var t:Float = segment * deltaT;
			var x:Float = (1 - t) * (1 - t) * x1 + 2 * t * (1 - t) * x2 + t * t * x3;
			var y:Float = (1 - t) * (1 - t) * y1 + 2 * t * (1 - t) * y2 + t * t * y3;
			points.push({x:x,y:y});
		}

		points.push({x:x3,y:y3});
		return points;
	}	
	
/**
	 * Draws a quadratic curve.
	 * @param	x1			X start.
	 * @param	y1			Y start.
	 * @param	x2			X control point, used to determine the curve.
	 * @param	y2			Y control point, used to determine the curve.
	 * @param	x3			X finish.
	 * @param	y3			Y finish.
	 * @param	segments	Increasing will smooth the curve but takes longer to render. Must be a value greater than zero.
	 */
	public function quadraticCurvePoints2(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, segments:Int = 25):Array<Float>
	{
		var points:Array<Float> = [];
		points.push(x1);
		points.push(y1);

		var deltaT:Float = 1 / segments;

		for (segment in 1...segments)
		{
			var t:Float = segment * deltaT;
			var x:Float = (1 - t) * (1 - t) * x1 + 2 * t * (1 - t) * x2 + t * t * x3;
			var y:Float = (1 - t) * (1 - t) * y1 + 2 * t * (1 - t) * y2 + t * t * y3;
			points.push(x);
			points.push(y);
		}

		points.push(x3);
		points.push(y3);
		return points;
	}	
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function rect(x:Float, y:Float, width:Float, height:Float):Array<Point>
	{
		return
		[
			{x:x,y:y},
			{x:x+width,y:y},	
			{x:x+width,y:y+height},	
			{x:x,y:y+height},
			{x:x,y:y}	
		];
	}

	static public inline function rect2(x:Float, y:Float, width:Float, height:Float):Array<Float>
	{
		return
		[
			x,y,
			x+width,y,
			x+width,y+height,
			x,y+height,
			x,y
		];
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function path(commands:Array<Int>, data:Array<Float>):Array<Array<Point>>
	{
		if (commands==null||data==null)
			return null;

		var polygons:Array<Array<Point>> = [];
		var p:Array<Point> = [];
		var ci:Int = 0;
		var penX:Float = 0;
		var penY:Float = 0;
		for (cmd in commands)
		{
			if (cmd == MOVE_TO)
			{
				if (ci>0)
				{
					if ( !(Math.abs(penX - data[ci+0]) < 0.00001 && Math.abs(penY - data[ci+1]) < 0.00001) && p.length>0)
					{
						polygons.push(p);
						p = [];
					}
				}
				penX=data[ci+0];
				penY=data[ci+1];
				p.push({x:penX,y:penY});
				ci++;					
				ci++;					
			}

			else if (cmd == LINE_TO)	
			{
				penX=data[ci+0];
				penY=data[ci+1];
				p.push({x:penX,y:penY});
				ci++;					
				ci++;					
			}	
			else if (cmd == CURVE_TO)	
			{
				// var x1 = ci < 2 ? 0.0 : data[ci-2];
				// var y1 = ci < 2 ? 0.0 : data[ci-1];
				var x1 = penX;
				var y1 = penY;
				var x2 = data[ci+0];
				var y2 = data[ci+1];
				var cx = data[ci+2];
				var cy = data[ci+3];
				for (cp in quadraticCurvePoints(x1,y1,cx,cy,x2,y2,10))
					p.push({x:cp.x,y:cp.y});
					
				penX=x2;
				penY=y2;
				ci+=4;					
			}	
		}
		if (p.length>0)
		{
			polygons.push(p);
		}		

		return polygons;
	}

	static public function path2(commands:Array<Int>, data:Array<Float>):Array<Array<Float>>
	{
		if (commands==null||data==null)
			return null;

		var polygons:Array<Array<Float>> = [];
		var p:Array<Float> = [];
		var ci:Int = 0;
		var penX:Float = 0;
		var penY:Float = 0;
		for (cmd in commands)
		{
			if (cmd == MOVE_TO)
			{
				if (ci>0)
				{
					if ( !(Math.abs(penX - data[ci+0]) < 0.00001 && Math.abs(penY - data[ci+1]) < 0.00001) && p.length>0)
					{
						polygons.push(p);
						p = [];
					}
				}
				penX=data[ci+0];
				penY=data[ci+1];
				p.push(penX);
				p.push(penY);
				ci++;					
				ci++;					
			}

			else if (cmd == LINE_TO)	
			{
				penX=data[ci+0];
				penY=data[ci+1];
				p.push(penX);
				p.push(penY);				
				ci++;					
				ci++;					
			}	
			else if (cmd == CURVE_TO)	
			{
				// var x1 = ci < 2 ? 0.0 : data[ci-2];
				// var y1 = ci < 2 ? 0.0 : data[ci-1];
				var x1 = penX;
				var y1 = penY;
				var x2 = data[ci+0];
				var y2 = data[ci+1];
				var cx = data[ci+2];
				var cy = data[ci+3];
				for (cp in quadraticCurvePoints(x1,y1,cx,cy,x2,y2,10))
				{
					p.push(cp.x);
					p.push(cp.y);
				}
				penX=x2;
				penY=y2;
				ci+=4;					
			}	
		}
		if (p.length>0)
		{
			polygons.push(p);
		}		

		return polygons;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
