package lib.utils;

import haxe.display.Protocol.Timer;
import lib.types.Point2D.Point;

enum SineBase
{
	Zero;
	Positive;
	Negative;
}

/**
 * ...
 * @author Tommy S
 */
class MathUtils
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline var TAU = 6.28318530717958648;
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	static public inline function pickRandom(val1,val2)
	{
		return Math.random()>0.5?val1:val2;
	}

	static public inline function distanceBetweenTwoPoints(x1:Float,y1:Float,x2:Float,y2:Float):Float
	{
		var dx:Float = x1 - x2;
		var dy:Float = y1 - y2;
		return Math.sqrt(dx * dx + dy * dy);
	}

	static public inline function radiansBetweenTwoPoints(x1:Float,y1:Float,x2:Float,y2:Float):Float
	{
		var dx:Float = x2 - x1;
		var dy:Float = y2 - y1;
		return Math.atan2(dy,dx);
	}
	
	static public function angleBetweenTwoPoints(x1:Float,y1:Float,x2:Float,y2:Float,normalized:Bool=false):Float
	{
		var dx:Float = x2 - x1;
		var dy:Float = y2 - y1;
		var mx = Math.atan2(dy, dx) / Math.PI;
		mx -= 0.5;
		if (mx < 0)
			mx += 2;
		if (normalized)
			return (mx * 0.5);
		else
			return (mx * 0.5) * 360;
	}
	
	static public function angleBetweenTwoPoints2(p1:Point,p2:Point,normalized:Bool=false):Float
	{
		return angleBetweenTwoPoints(p1.x,p1.y,p2.x,p2.y,normalized);
	}
	
	static public function midPoint(p1:Point,p2:Point):Point
	{
    	return {x:(p1.x + p2.x) / 2, y:(p1.y + p2.y) / 2};
	}
	
	static public function pointInEllipse(pX:Float, pY:Float, centerX:Float, centerY:Float, width:Float, height:Float):Bool
	{
		var dx = pX - centerX;
		var dy = pY - centerY;
		return ( dx * dx ) / ( width * width ) + ( dy * dy ) / ( height * height ) <= 1;
	}
	
	static public inline function radiansToDegrees(radians:Float):Float
	{
		return radians * 180/Math.PI;
	}	
	
	static public inline function degreesToRadians(degrees:Float):Float 
	{
		return degrees * Math.PI / 180;
	}
 
	public static function rangeMapper(num:Float, inMin:Float, inMax:Float, outMin:Float, outMax:Float, round:Bool = false, constrainMin:Bool = true, constrainMax:Bool = true):Float
	{
		if (constrainMin && num < inMin) return outMin;
		if (constrainMax && num > inMax) return outMax;
	 
		var num1:Float = (num - inMin) / (inMax - inMin);
		var num2:Float = (num1 * (outMax - outMin)) + outMin;
		if (round) return Math.round(num2);
		return num2;
	}	
	
	public static inline function flattenPositive(val:Float):Float
	{
		if (val>0)
			return 0;
		else 
			return val;
	}	
	
	public static inline function biDirectionalClamp(val:Float, min:Float=0, max:Float=1):Float
	{
		if (val>=0)
			return Math.max(min, Math.min(max, val));
		else 
			return -Math.max(min, Math.min(max, Math.abs(val)));
	}	

	public static inline function clamp(val:Float, min:Float=0, max:Float=1):Float
	{
		return Math.max(min, Math.min(max, val));
	}	

	public static inline function clampInt(val:Int, min:Int=0, max:Int=1):Int
	{
		return Math.round(clamp(val,min,max));
	}	
	
	static public function randomInRange(minNum:Float, maxNum:Float,?centerZero:Bool=false):Float
	{
		if (!centerZero)
			return (Math.random() * (maxNum - minNum) ) + minNum;
		else
		{
			var vl = (Math.random() * (maxNum - minNum) ) + minNum;
			return vl-(maxNum*0.5);
		}
	}
	
	static public function getRandomIntInRange(minNum:Int, maxNum:Int, ?avoidList:Array<Int>):Int
	{
		if (avoidList==null || avoidList.length==0)
			return Math.floor( (Math.random() * (maxNum - minNum)) ) + minNum;
		else
		{
			while (true)
			{
				var r = Math.floor( (Math.random() * (maxNum - minNum)) ) + minNum;
				if (!avoidList.contains(r))
					return r;
			}
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public function randomPointInCircle(?outerRadius:Float=1, ?innerRadius:Float=0, aroundCenter:Bool=true):Point
	{
		final angle = Math.random()*Math.PI*2;
		final r = Math.sqrt(Math.random());

		if (aroundCenter)
		{
			return
			{
				x: r*Math.cos(angle)*outerRadius, 
				y: r*Math.sin(angle)*outerRadius
			};
		}
		else
		{
			return
			{
				x: (r*Math.cos(angle)*outerRadius)+outerRadius, 
				y: (r*Math.sin(angle)*outerRadius)+outerRadius
			};
		}
	}
	
	static public function gaussianRandom():Float
	{
	    var rand = Math.random();
	    rand += Math.random();
	    rand += Math.random();
	    rand += Math.random();
	    rand += Math.random();
	    rand += Math.random();
  		return rand / 6;
}

	static public inline function gaussianRandomInRange(start:Float, end:Float):Float
	{
		return Math.floor(start + gaussianRandom() * (end - start + 1));
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function lerp(a:Float, b:Float, alpha:Float)
	{
		return (1 - alpha) * a + alpha * b;
	}
	
	static public inline function lerpCubic(a:Float, b:Float, alpha:Float)
	{
		return Ease.easeInOutCubic(alpha,a,b,1);
	}
	
	static public inline function lerpQuad(a:Float, b:Float, alpha:Float)
	{
		return Ease.easeInOutQuad(alpha,a,b,1);
	}

	static public inline function lerpSine(a:Float, b:Float, alpha:Float)
	{
		return Ease.easeInOutSine(alpha,a,b,1);
	}

/*	static public function slerp(start:FVector, end:FVector, percent:Float):FVector
	{
		var dot:Float = FVector.DotProduct(start, end);     
		dot = MathUtils.clamp(dot, -1.0, 1.0);
		var theta:Float  = Math.acos(dot)*percent;
		var relativeVec:FVector = end - start*dot;
		relativeVec = relativeVec.GetSafeNormal();
		return ((start*Math.cos(theta)) + (relativeVec*Math.sin(theta)));
	}	*/	
	
	static public function sineCurve(?amplitude:Float=1.0,?freq:Float=1.0,?offset:Float=0,?time:Float=0,?animated:Bool=true,?curveBase:SineBase=SineBase.Zero):Float
	{
		var t = time;
		if (animated)
			t = haxe.Timer.stamp();
		var o = 0.0;
		switch (curveBase) 
		{
			case SineBase.Zero:
			{
				o = 0;
			}
			case SineBase.Positive:
			{
				o = 1;
			}
			case SineBase.Negative:
			{
				o = -1;
			}
		}
			
		return (((Math.sin(t * freq) + o) *0.5) * amplitude)+offset;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	static public inline function isPointInRange(x1:Float,y1:Float,x2:Float,y2:Float,radius:Float):Bool
	{
		return Math.abs(distanceBetweenTwoPoints(x1,y1,x2,y2)) <= radius;		
	}

	
	/////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * Returns a random integer between a and b, inclusive. B must be higher than a.
	 * If b is null, returns a random integer between 0 and a.
	 */
	inline public static function rndInt(a:Int, ?b:Int): Int
	{ 
		if(b == null)
			return rndInt(0, a);

		return (Math.floor(Math.random() * (b - a + 1) + a));
	}

	/**
	 * Flips a coin. Returns true on heads, false on tails.
	 * 
	 * @param trueChance If supplied, changes the probability of heads (defaults to 0.5/50%)
	 * @returns A random true or false
	 */
	inline public static function rndBool(trueChance:Float = 0.5): Bool
	{
		return (Math.random() < trueChance);
	}

	/**
	 * Returns a random vector2 between a and b. B must be higher than a.
	 * If b is null, returns a random float between 0 and a.
	 */
/* 	inline public static function rndVec2(a:Float, ?b:Float):Vector2
	{
		if(b == null)
			return new Vector2(rnd(0.0, a),rnd(0.0, a));

		return new Vector2(Math.random()*(b-a)+a,Math.random()*(b-a)+a);
	}	
 */
	/**
	 * Returns a random float between a and b. B must be higher than a.
	 * If b is null, returns a random float between 0 and a.
	 */
	inline public static function rnd(a:Float, ?b:Float): Float
	{
		if(b == null)
			return rnd(0.0, a);

		return (Math.random() * (b - a) + a);
	}	

    public static function roundTo(value:Float, precision:Int): Float
    {
        var factor = Math.pow(10, precision);
        return Math.round(value*factor) / factor;
    }

	public static function sign(v:Float): Int
	{
		if(v < 0.0)
			return -1;
		if(v > 0.0)
			return 1;
		return 0;
	}

	public static function min<T:Float,Int>(a:T, b:T): T
	{
		return (a < b ? a : b);
	}

	public static function max<T:Float,Int>(a:T, b:T): T
	{
		return (a > b ? a : b);
	}

	public static function abs<T:Float,Int>(num:T): T
	{
		return (num < 0 ? -num : num);
	}

    public static function diff<T:Float,Int>(a:T, b:T): T
    {
        return (a > b ? a - b : b - a);
    }

    public static function isEven(a:Int): Bool
    {
    	return (Math.floor(a/2)*2) == a;
    }

	/**
	 * Returns true if both floats match within tolerance decimal places.
	 */
    public static function matches(a:Float, b:Float, tolerance:Int = 0): Bool
    {
        return (roundTo(a, tolerance) == roundTo(b, tolerance));
    }
	
	/////////////////////////////////////////////////////////////////////////////////////

	public static inline function minMulti(...values):Float
	{
		if (values.length==1)
			return values[0];

		var l=values[0];
		for (i in 1...values.length)
			l = Math.min(l,values[i]);

		return l;
	}

	public static inline function maxMulti(...values):Float
	{
		if (values.length==1)
			return values[0];

		var l=values[0];
		for (i in 1...values.length)
			l = Math.max(l,values[i]);

		return l;
	}

	public static inline function getHighestInt(numbers:Array<Int>):Int
	{
		if (numbers==null || numbers.length==0)
			return 0;
		else if (numbers.length==1)
			return numbers[1];
		else
		{
			var h:Int = 0;
			for (n in numbers)
				if ( n>h )
					h = n;

			return h;
		}
	}

	public static function getBiggestFloat(numbers:Array<Float>):Float
	{
		if (numbers==null || numbers.length==0)
			return 0;
		else if (numbers.length==1)
			return numbers[1];
		else
		{
			var isAllNeg:Bool = true;
			for (n in numbers)
			{
				if (n>0)
				{
					isAllNeg=false;
					break;
				}
			}

			var h:Float = 0;
			if (isAllNeg)
			{
				for (n in numbers)
					if ( n<h )
						h = n;
			}
			else
			{
				for (n in numbers)
					if ( n>h )
						h = n;
			}
			return h;
		}
	}

	/////////////////////////////////////////////////////////////////////////////////////

	public static inline function round(number:Float, ?precision=15):Float
	{
		number *= Math.pow(10, precision);
		return Math.round(number) / Math.pow(10, precision);
	}

	/////////////////////////////////////////////////////////////////////////////////////

}