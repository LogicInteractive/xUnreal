package lib.utils;

import lib.types.FastFloat;
import lib.types.Rectangle;
import lib.types.geo.PointQuad;
import lib.types.math.FastMatrix3;
import lib.types.math.FastVector2;

class FastMatrix3Tools
{
	/////////////////////////////////////////////////////////////////////////////////////

	@:noUsing
	static public inline function createAlt2(tx:FastFloat,ty:FastFloat,a:FastFloat,b:FastFloat,c:FastFloat,d:FastFloat):FastMatrix3
	{
		var m:FastMatrix3 = FastMatrix3.identity();
		m = FastMatrix3.rotation(b).multmat(m);
		m = FastMatrix3.rotation(b).multmat(m);
		m = FastMatrix3.scale(a,d).multmat(m);
		m = FastMatrix3.translation(tx,ty).multmat(m);
		return m;
	}

	@:noUsing
	static public inline function buildTransform(translateX:Float=0,translateY:Float=0,rotateDeg:Float=0,scaleX:Float=1,scaleY:Float=1):FastMatrix3
	{
		var m:FastMatrix3 = FastMatrix3.rotation(rotateDeg*(Math.PI/180));
		m = FastMatrix3.scale(scaleX,scaleY).multmat(m);
		m = FastMatrix3.translation(translateX,translateY).multmat(m);
		return m;
	}

	@:noUsing
	static public inline function buildTransformWithCenter(translateX:Float=0,translateY:Float=0,rotateDeg:Float=0,scaleX:Float=1,scaleY:Float=1,centerX:Float=0.0,centerY:Float=0.0):FastMatrix3
	{
		var m:FastMatrix3 = FastMatrix3.translation(-centerX,-centerY);
		m = FastMatrix3.rotation(rotateDeg*(Math.PI/180)).multmat(m);
		m = FastMatrix3.scale(scaleX,scaleY).multmat(m);
		// m = FastMatrix3.translation(centerX,centerY).multmat(m);
		m = FastMatrix3.translation(translateX,translateY).multmat(m);
		return m;
	}

	@:noUsing
	static public inline function buildTransformWithOffsetCenter(translateX:Float=0,translateY:Float=0,rotateDeg:Float=0,scaleX:Float=1,scaleY:Float=1,centerX:Float=0.0,centerY:Float=0.0,offsetX:Float=0.0,offsetY:Float=0.0):FastMatrix3
	{
		var m:FastMatrix3 = FastMatrix3.translation(-centerX,-centerY);
		m = FastMatrix3.rotation(rotateDeg*(Math.PI/180)).multmat(m);
		m = FastMatrix3.scale(scaleX,scaleY).multmat(m);
		m = FastMatrix3.translation(centerX,centerY).multmat(m);
		m = FastMatrix3.translation(translateX,translateY).multmat(m);
		return m;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function transformPoint(m:FastMatrix3,x:Float,y:Float):FastVector2
	{
		return
		{
			x:x * m._00 + y * m._10 + m._20, 
			y:x * m._01 + y * m._11 + m._21
		}
	}

	static public inline function transformRect(m:FastMatrix3,rect:Rectangle):Rectangle
	{
		var q:PointQuad = transformQuad(m,rect.x,rect.y,rect.width,rect.height);
		return new Rectangle(q.x1,q.y1,q.x2-q.x1,q.y3-q.y2);
	}

	static public inline function transformRectToQuad(m:FastMatrix3,rect:Rectangle):PointQuad
	{
		return transformQuad(m,rect.x,rect.y,rect.width,rect.height);
	}

	static public inline function transformQuad(m:FastMatrix3,x:Float,y:Float,width:Float,height:Float):PointQuad
	{
		return
		{
			x1:x * m._00 + y * m._10 + m._20, 
			y1:x * m._01 + y * m._11 + m._21,
			x2:(x+width) * m._00 + y * m._10 + m._20, 
			y2:(x+width) * m._01 + y * m._11 + m._21,
			x3:(x+width) * m._00 + (y+height) * m._10 + m._20, 
			y3:(x+width) * m._01 + (y+height) * m._11 + m._21,
			x4:x * m._00 + (y+height) * m._10 + m._20, 
			y4:x * m._01 + (y+height) * m._11 + m._21,
		};
	}

	static public function decompose(m:FastMatrix3)
	{
		var E = (m._00 + m._11) / 2;
		var F = (m._00 - m._11) / 2;
		var G = (m._10 + m._01) / 2;
		var H = (m._10 - m._01) / 2;

		var Q = Math.sqrt(E * E + H * H);
		var R = Math.sqrt(F * F + G * G);
		var a1 = Math.atan2(G, F);
		var a2 = Math.atan2(H, E);
		var theta = (a2 - a1) / 2;
		var phi = (a2 + a1) / 2;

		var r = ((-phi * 180 / Math.PI)*2);
		var sx = Q + R;
		var sy = Q - R;
		// var r = ( (180/Math.PI) * Math.atan2( ((0*sx)+(1*sy)),((0*m._20)-(1*m._21)))) - 90;
		if (r<0)
			r=180+(180+r);

		return
		{
			translateX: m._20,
			translateY: m._21,
			rotate: r%360,
			scaleX: sx,
			scaleY: sy,
			skew: -theta * 180 / Math.PI
		};
	}

	static public inline function getX(m:FastMatrix3):Float
	{
		return m._20;
	}		

	static public inline function getY(m:FastMatrix3):Float
	{
		return m._21;
	}		

	static public inline function getPosition(m:FastMatrix3):FastVector2
	{
		return {x:m._20,y:m._21};
	}		

	static public function getRotation(m:FastMatrix3):Float
	{
		var E = (m._00 + m._11) / 2;
		var F = (m._00 - m._11) / 2;
		var G = (m._10 + m._01) / 2;
		var H = (m._10 - m._01) / 2;

		var a1 = Math.atan2(G, F);
		var a2 = Math.atan2(H, E);
		var phi = (a2 + a1) / 2;

		var r = ((-phi * 180 / Math.PI)*2);
		if (r<0)
			r=180+(180+r);

		return r;
	}		

	static public function getScaleX(m:FastMatrix3):Float
	{
		var E = (m._00 + m._11) / 2;
		var F = (m._00 - m._11) / 2;
		var G = (m._10 + m._01) / 2;
		var H = (m._10 - m._01) / 2;

		var Q = Math.sqrt(E * E + H * H);
		var R = Math.sqrt(F * F + G * G);

		return Q + R;
	}		

	static public function getScaleY(m:FastMatrix3):Float
	{
		var E = (m._00 + m._11) / 2;
		var F = (m._00 - m._11) / 2;
		var G = (m._10 + m._01) / 2;
		var H = (m._10 - m._01) / 2;

		var Q = Math.sqrt(E * E + H * H);
		var R = Math.sqrt(F * F + G * G);

		return Q - R;
	}		

	static public function clone(m:FastMatrix3):FastMatrix3
	{
		return new FastMatrix3(m._00, m._10, m._20, m._01, m._11, m._21, m._02, m._12, m._22);
	}

	static public inline function getTransformX(m:FastMatrix3,x:Float, y:Float):Float
	{
		return m._00 * x + m._10 * y + m._20;
	}

	static public inline function getTransformY(m:FastMatrix3,x:Float, y:Float):Float
	{
		return m._01 * x + m._11 * y + m._21;
	}

	static public inline function getA(m:FastMatrix3):FastFloat return m._00;
	static public inline function setA(m:FastMatrix3,value:FastFloat):FastFloat return m._00 = value;

	static public inline function getB(m:FastMatrix3):FastFloat return m._01;
	static public inline function setB(m:FastMatrix3,value:FastFloat):FastFloat return m._01 = value;

	static public inline function getC(m:FastMatrix3):FastFloat return m._10;
	static public inline function setC(m:FastMatrix3,value:FastFloat):FastFloat return m._10 = value;

	static public inline function getD(m:FastMatrix3):FastFloat return m._11;
	static public inline function setD(m:FastMatrix3,value:FastFloat):FastFloat return m._11 = value;

	/////////////////////////////////////////////////////////////////////////////////////

}