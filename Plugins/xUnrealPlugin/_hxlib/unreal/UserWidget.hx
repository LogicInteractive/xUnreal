package unreal;

import lib.graphics.ShapePoints;
import unreal.UWidget;
import unreal.types.FloatArray;
import unreal.types.Vector2D;

typedef PaintContext = cpp.Star<cpp.Void>;

@:nogenerate 
@:cppFileCode('
#include <../../../_hxlib/unreal/types/Vector2D.h>
#include <../../../_hxlib/unreal/types/FloatArray.h>
void _DrawLine(void* Context, Vector2D PositionA, Vector2D PositionB, uint32_t Tint, bool bAntiAlias, float Thickness);
void _DrawLines(void* Context, FloatArray Points, uint32_t Tint, bool bAntiAlias, float Thickness);
void _DrawText(void* Context, const char* string, double x, double y, uint32_t Tint);
')
class UserWidget extends unreal.UWidget
{
	/////////////////////////////////////////////////////////////////////////////////////

	var paintContext:PaintContext;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	public function NativeConstruct()
	{
	}
	
	public function NativeOnInitialized()
	{
	}
	
	public function NativePreConstruct()
	{
	}
	
	public function NativeDestruct()
	{
	}

	@:noCompletion
	public function NativePaint(context:PaintContext)
	{
		this.paintContext = context;
		OnPaint();
	}

	public function OnPaint()
	{
	}

	public function NativeTick(inDeltaTime:Float)
	{
		Tick(inDeltaTime);
	}

	public function Tick(InDeltaTime:Float)
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function drawLine(x1:Float,y1:Float,x2:Float,y2:Float, tint:UInt=0xffffffff, bAntiAlias:Bool=true, thickness:Float=1.0)
	{
		if (paintContext==null)
			return;
		untyped __global__._DrawLine(paintContext,Vector2D.create(x1,y1),Vector2D.create(x2,y2),tint,bAntiAlias,thickness);
	}

	function drawLine2(p1:Vector2D,p2:Vector2D, tint:UInt=0xffffffff, bAntiAlias:Bool=true, thickness:Float=1.0)
	{
		if (paintContext==null)
			return;
		untyped __global__._DrawLine(paintContext,p1,p2,tint,bAntiAlias,thickness);
	}

	function drawLines(points:Array<Float>, tint:UInt=0xffffffff, bAntiAlias:Bool=true, thickness:Float=1.0)
	{
		if (paintContext==null)
			return;
		untyped __global__._DrawLines(paintContext,FloatArray.create(points),tint,bAntiAlias,thickness);
	}

	function drawText(text:String, x:Float=0.0, y:Float=0.0, tint:UInt=0xffffffff)
	{
		if (paintContext==null)
			return;
		untyped __global__._DrawText(paintContext,text,x,y,tint);
	}

	function drawCircle(x:Float,y:Float,radius:Float=50,tint:UInt=0xffffffff,bAntiAlias:Bool=true,thickness:Float=1.0)
	{
		drawLines(ShapePoints.circle2(x,y,radius),tint,bAntiAlias,thickness);
	}

	function drawRect(x:Float,y:Float,width:Float=100,height:Float=100,tint:UInt=0xffffffff,bAntiAlias:Bool=true,thickness:Float=1.0)
	{
		drawLines(ShapePoints.rect2(x,y,width,height),tint,bAntiAlias,thickness);
	}
	function drawRoundedRect(x:Float,y:Float,width:Float=100,height:Float=100,radius:Float=10,tint:UInt=0xffffffff,bAntiAlias:Bool=true,thickness:Float=1.0)
	{
		drawLines(ShapePoints.roundedRect2(x,y,width,height,radius),tint,bAntiAlias,thickness);
	}

	// function drawBox(text:String, x:Float=0.0, y:Float=0.0, tint:UInt=0xffffff)
	// {
	// 	if (paintContext==null)
	// 		return;
	// 	untyped __global__._DrawText(paintContext,text,x,y,tint);
	// }

	/////////////////////////////////////////////////////////////////////////////////////
}
