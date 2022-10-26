package lib.utils;

import haxe.xml.Fast;
import lib.types.Rectangle;
import lib.types.math.FastMatrix3;
import lib.types.math.FastMatrix4;
import lib.types.math.FastVector2;
import lib.typs.FastFloat;

using fox.utils.FastMatrix3Tools;

class MatrixUtils 
{
	/////////////////////////////////////////////////////////////////////////////////////

	/////////////////////////////////////////////////////////////////////////////////////

	public static function fastMatrix3to4(m:FastMatrix3):FastMatrix4
	{
		return new FastMatrix4(
			1 * m._00 + 0 * m._01 + 0, 1 * m._10 + 0 * m._11 + 0 * m._12, 1 * m._20 + 0 * m._21 + 0 * m._22, 0,
			0 * m._00 + 1 * m._01 + 0, 0 * m._10 + 1 * m._11 + 0 * m._12, 0 * m._20 + 1 * m._21 + 0 * m._22, 0,
			0 * m._00 + 0 * m._01 + 1, 0 * m._10 + 0 * m._11 + 1 * m._12, 0 * m._20 + 0 * m._21 + 1 * m._22, 0,
			0, 0, 0, 1
		);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	public static inline function scaleRectangleFM3(matrix:FastMatrix3,?sourceRect:Rectangle):Rectangle
	{
		if (sourceRect!=null)
			return
			{
				x:sourceRect.x+getX(matrix),
				y:sourceRect.y+getY(matrix),
				width:sourceRect.width*getScaleX(matrix),
				height:sourceRect.height*getScaleY(matrix)
			};
		else
			return
			{
				x:getX(matrix),
				y:getY(matrix),
				width:getScaleX(matrix),
				height:getScaleY(matrix)
			};
	}

	public static inline function getX(matrix:FastMatrix3):FastFloat
	{
		return matrix._20;
	}

	public static inline function getY(matrix:FastMatrix3):FastFloat
	{
		return matrix._21;
	}

	public static inline function getScaleX(matrix:FastMatrix3):FastFloat
	{
		return matrix._00;
	}

	public static inline function getScaleY(matrix:FastMatrix3):FastFloat
	{
		return matrix._11;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:noUsing
	static public function matrixToMatrixRect(local:Rectangle,matrix:FastMatrix3):Rectangle
	{
		 if (local==null || matrix==null)
			return local;

		var p1:FastVector2 = matrixToMatrixPoint(local.x,local.y,matrix);
		var p2:FastVector2 = matrixToMatrixPoint(local.x+local.width,local.y+local.height,matrix);
		return
		{
			x:p1.x,
			y:p1.y,
			width:p2.x-p1.x,
			height:p2.y-p1.y
		};
	}

	@:noUsing
	static public inline function matrixToMatrixPoint(localX:Float=0,localY:Float=0,matrix:FastMatrix3):FastVector2
	{
		if (matrix==null)
			return {x:localX,y:localY};
			
		return matrix.inverse().transformPoint(localX,localY);		
	}


	/////////////////////////////////////////////////////////////////////////////////////
}