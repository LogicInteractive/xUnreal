package lib.types;

import lib.types.Point2D.Point;
import lib.types.math.FastVector4;

@:structInit
class Rectangle
{
	public var bottomRight(get, set):Point;
	@:isVar
	public var left(get, set):Float;
	@:isVar
	public var right(get, set):Float;
	@:isVar
	public var size(get, set):Point;
	@:isVar
	public var top(get, set):Float;
	@:isVar
	public var bottom(get, set):Float;
	@:isVar
	public var topLeft(get, set):Point;
	@:isVar
	public var x(get, set):Float;
	@:isVar
	public var y(get, set):Float;

	@:isVar
	public var width:Float;

	@:isVar
	public var height:Float;

	// public var x:Null<Float>;
	// public var y:Null<Float>;
	public var isFrozen:Bool = false;
	
	var frozen:Rectangle;

	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):Void
	{
		this.left = x;
		this.top = y;
		this.right = x+width;
		this.bottom = y+height;
	}

	public static function fromMaxMin(xMin:Float,yMin:Float,xMax:Float,yMax:Float)
	{
		var r = new Rectangle();
		r.left = xMin;
		r.top = yMin;
		r.right = xMax;
		r.bottom = yMax;
		return r;
	}

	public function maxMin(xMin:Float,yMin:Float,xMax:Float,yMax:Float)
	{
		final r = this;		
		r.left = xMin;
		r.top = yMin;
		r.right = xMax;
		r.bottom = yMax;
	}

	public function setFromBounds(heapsBounds:h2d.col.Bounds)
	{
		this.left = heapsBounds.xMin;		
		this.top = heapsBounds.yMin;		
		this.right = heapsBounds.xMax;		
		this.bottom = heapsBounds.yMax;		
	}

	public function freeze()
	{
		frozen = new Rectangle(x, y, width, height);
		isFrozen = true;
	}

	public function unfreeze()
	{
		reset();
		frozen = null;
		isFrozen = false;
	}

	public inline function clone():Rectangle
	{
		return new Rectangle(x, y, width, height);
	}

	public function reset()
	{
		if (frozen!=null)
			copyFrom(frozen);
		else 
			clear();	
	}

	public function clear()
	{
		top=left=right=bottom=0;
	}

	public function contains(x:Float, y:Float):Bool
	{
		// return x >= this.x && y >= this.y && x < (this.x+right) && y < (this.y+bottom);

		if (x<this.x)				return false;
		if (y<this.y)				return false;
		if (x>(this.width+this.x))	return false;
		if (y>(this.height+this.y))	return false;

		return true;
	}

	public function containsPoint(point:Point,offsetX:Float=0,offsetY:Float=0):Bool
	{
		return contains(point.x+offsetX, point.y+offsetY);
	}

	public function containsRect(rect:Rectangle):Bool
	{
		return contains(rect.x,rect.y) && contains(rect.x+rect.width,rect.y+rect.height);
	}

	public function copyFrom(sourceRect:Rectangle):Void
	{
		left = sourceRect.left;
		top = sourceRect.top;
		right = sourceRect.right;
		bottom = sourceRect.bottom;
	}

	public function copyTo(destRect:Rectangle):Void
	{
		destRect.left = left;
		destRect.top = top;
		destRect.right = right;
		destRect.bottom = bottom;
	}

	public function equals(toCompare:Rectangle):Bool
	{
		if (toCompare == this) return true;
		else
			return toCompare != null && x == toCompare.x && y == toCompare.y && width == toCompare.width && height == toCompare.height;
	}

	public inline function inflate(dx:Float, dy:Float):Void
	{
		left -= dx;
		right += dx;
		top -= dy;
		bottom += dy;
	}

	public inline function multiply(scalar:Float)
	{
		left*=scalar;
		right*=scalar;
		top*=scalar;
		bottom*=scalar;
	}

	public inline function divide(divident:Float)
	{
		if (divident==0)
			return;

		left/=divident;
		right/=divident;
		top/=divident;
		bottom/=divident;
	}

	public function inflatePoint(point:Point):Void
	{
		inflate(point.x, point.y);
	}

	public function intersection(toIntersect:Rectangle):Rectangle
	{
		var x0 = x < toIntersect.x ? toIntersect.x : x;
		var x1 = right > toIntersect.right ? toIntersect.right : right;

		if (x1 <= x0)
		{
			return new Rectangle();
		}

		var y0 = y < toIntersect.y ? toIntersect.y : y;
		var y1 = bottom > toIntersect.bottom ? toIntersect.bottom : bottom;

		if (y1 <= y0)
		{
			return new Rectangle();
		}

		return new Rectangle(x0, y0, x1 - x0, y1 - y0);
	}

	public function intersect(toIntersect:Rectangle)
	{
		setFrom(this.intersection(toIntersect));
	}

	public function intersects(toIntersect:Rectangle):Bool
	{
		var x0 = x < toIntersect.x ? toIntersect.x : x;
		var x1 = right > toIntersect.right ? toIntersect.right : right;

		if (x1 <= x0)
		{
			return false;
		}

		var y0 = y < toIntersect.y ? toIntersect.y : y;
		var y1 = bottom > toIntersect.bottom ? toIntersect.bottom : bottom;

		return y1 > y0;
	}

	public function isEmpty():Bool
	{
		return (width <= 0 || height <= 0);
	}

	public function offset(dx:Float, dy:Float):Void
	{
		x += dx;
		y += dy;
	}

	public function offsetPoint(point:Point):Void
	{
		x += point.x;
		y += point.y;
	}

	public function setEmpty():Void
	{
		x = y = width = height = 0;
	}

	public function setTo(x:Float, y:Float, width:Float, height:Float):Void
	{
		this.left = x;
		this.top = y;
		this.right = x+width;
		this.bottom = y+height;
	}

	public inline function setFrom(fromRect:Rectangle):Void
	{
		if (fromRect==null)
			return;

		x = fromRect.x;
		y = fromRect.y;
		width = fromRect.width;
		height = fromRect.height;
	}

	public function toString():String
	{
		return '(x=$x, y=$y, width=$width, height=$height)';
	}

	public function union(toUnion:Rectangle):Rectangle
	{
		if (width == 0 || height == 0)
		{
			return toUnion.clone();
		}
		else if (toUnion.width == 0 || toUnion.height == 0)
		{
			return clone();
		}

		var x0 = x > toUnion.x ? toUnion.x : x;
		var x1 = right < toUnion.right ? toUnion.right : right;
		var y0 = y > toUnion.y ? toUnion.y : y;
		var y1 = bottom < toUnion.bottom ? toUnion.bottom : bottom;

		return new Rectangle(x0, y0, x1 - x0, y1 - y0);
	}

	public function getCenterPoint():Point2D
	{
		return 
		{
			x:(width*0.5)+x,
			y:(height*0.5)+y,
		}
	}

	@:noCompletion private function __contract(x:Float, y:Float, width:Float, height:Float):Void
	{
		if (this.width == 0 && this.height == 0)
		{
			return;
		}

		var offsetX = 0.0;
		var offsetY = 0.0;
		var offsetRight = 0.0;
		var offsetBottom = 0.0;

		if (this.x < x) offsetX = x - this.x;
		if (this.y < y) offsetY = y - this.y;
		if (this.right > x + width) offsetRight = (x + width) - this.right;
		if (this.bottom > y + height) offsetBottom = (y + height) - this.bottom;

		this.x += offsetX;
		this.y += offsetY;
		this.width += offsetRight - offsetX;
		this.height += offsetBottom - offsetY;
	}

	@:noCompletion private function __expand(x:Float, y:Float, width:Float, height:Float):Void
	{
		if (this.width == 0 && this.height == 0)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			return;
		}

		var cacheRight = right;
		var cacheBottom = bottom;

		if (this.x > x)
		{
			this.x = x;
			this.width = cacheRight - x;
		}
		if (this.y > y)
		{
			this.y = y;
			this.height = cacheBottom - y;
		}
		if (cacheRight < x + width) this.width = x + width - this.x;
		if (cacheBottom < y + height) this.height = y + height - this.y;
	}

	public function transformMatrix(m:Matrix)
	{
		var tx0 = m.a * x + m.c * y;
		var tx1 = tx0;
		var ty0 = m.b * x + m.d * y;
		var ty1 = ty0;

		var tx = m.a * (x + width) + m.c * y;
		var ty = m.b * (x + width) + m.d * y;

		if (tx < tx0) tx0 = tx;
		if (ty < ty0) ty0 = ty;
		if (tx > tx1) tx1 = tx;
		if (ty > ty1) ty1 = ty;

		tx = m.a * (x + width) + m.c * (y + height);
		ty = m.b * (x + width) + m.d * (y + height);

		if (tx < tx0) tx0 = tx;
		if (ty < ty0) ty0 = ty;
		if (tx > tx1) tx1 = tx;
		if (ty > ty1) ty1 = ty;

		tx = m.a * x + m.c * (y + height);
		ty = m.b * x + m.d * (y + height);

		if (tx < tx0) tx0 = tx;
		if (ty < ty0) ty0 = ty;
		if (tx > tx1) tx1 = tx;
		if (ty > ty1) ty1 = ty;

		var rect:Rectangle = new Rectangle();
		rect.setTo(tx0 + m.tx, ty0 + m.ty, tx1 - tx0, ty1 - ty0);
		return rect;
	}

	// Getters & Setters

	@:noCompletion private function get_x():Float
	{
		return x;
	}

	@:noCompletion private function set_x(value:Float):Float
	{
		x=value;
		@:bypassAccessor left=x;
		// width = right-left;
		return x;
	}

	@:noCompletion private function get_y():Float
	{
		return y;
	}

	@:noCompletion private function set_y(value:Float):Float
	{
		y=value;
		@:bypassAccessor top=y;
		// height = bottom-top;		
		return y;
	}

	@:noCompletion private function get_bottom():Float
	{
		return bottom;
	}

	@:noCompletion private function set_bottom(b:Float):Float
	{
		bottom = b;
		height = bottom-top;
		return b;
	}

	@:noCompletion private function get_bottomRight():Point
	{
		return {x:x + width, y:y + height};
	}

	@:noCompletion private function set_bottomRight(p:Point):Point
	{
		width = p.x - x;
		height = p.y - y;
		return {x:p.x,y:p.y};
	}

	@:noCompletion private function get_width():Float
	{
		return width;
	}

	@:noCompletion private function set_width(w:Float):Float
	{
		width = w;
		@:bypassAccessor right = left+w;
		return w;
	}

	@:noCompletion private function get_height():Float
	{
		return height;
	}

	@:noCompletion private function set_height(h:Float):Float
	{
		height = h;
		@:bypassAccessor bottom = top+h;
		return h;
	}

	@:noCompletion private function get_left():Float
	{
		return left;
	}

	@:noCompletion private function set_left(l:Float):Float
	{
		left=l;
		width = right-left;
		@:bypassAccessor x = left;
		return l;
	}

	@:noCompletion private function get_right():Float
	{
		return right;
	}

	@:noCompletion private function set_right(r:Float):Float
	{
		right=r;
		width = right-left;
		return r;
	}

	@:noCompletion private function get_size():Point
	{
		return {x:width, y:height};
	}

	@:noCompletion private function set_size(p:Point):Point
	{
		width = p.x;
		height = p.y;
		return {x:p.x,y:p.y};
	}

	@:noCompletion private function get_top():Float
	{
		return top;
	}

	@:noCompletion private function set_top(t:Float):Float
	{
		top=t;
		height = bottom-top;
		@:bypassAccessor y = t;
		return t;
	}

	@:noCompletion private function get_topLeft():Point
	{
		return {x:x, y:y};
	}

	@:noCompletion private function set_topLeft(p:Point):Point
	{
		x = p.x;
		y = p.y;
		return {x:x,y:y};
	}

	public function transform(rect:Rectangle):Rectangle
	{
		x+=rect.x;
		y+=rect.y;
		width*=rect.width;
		height*=rect.height;
		return this;
	}

	public function translate(x:Float,y:Float):Rectangle
	{
		this.x+=x;
		this.y+=y;
		return this;
	}

	public inline function toFastVector4():FastVector4
	{
		return {x:x,y:y,z:width,w:height};
	}

	public inline function toQuad():stage.types.geo.PointQuad
	{
		return
		{
			x1:x,
			y1:y,
			x2:x+width,
			y2:y,
			x3:x+width,
			y3:y+height,
			x4:x,
			y4:y+height
		};
	}

	public function cloneTransform(rect:Rectangle):Rectangle
	{
		return 
		{
			x:x+rect.x,
			y:y+=rect.y,
			width:width*=rect.width,
			height:height*=rect.height
		};
	}

	public function merge(rect:Rectangle):Rectangle
	{
		if (rect.left < left) left=rect.left; 
		if (rect.right > right) right=rect.right;
		if (rect.top < top) top=rect.top; 
		if (rect.bottom > bottom) bottom=rect.bottom;
		return this;
	}

	public inline function setIfLowerX(checkX:Float)
	{
		if (checkX<x)
			x=checkX;
	}

	public inline function setIfLowerY(checkY:Float)
	{
		if (checkY<y)
			y=checkY;
	}

	public inline function setIfHigherX(checkX:Float)
	{
		if (checkX>x)
			x=checkX;
	}

	public inline function setIfHigherY(checkY:Float)
	{
		if (checkY>y)
			y=checkY;
	}

	public inline function setIfLowerWidth(checkWidth:Float)
	{
		if (checkWidth<width)
			width=checkWidth;
	}

	public inline function setIfLowerHeight(checkHeight:Float)
	{
		if (checkHeight<y)
			y=checkHeight;
	}

	public inline function setIfHigherWidth(checkWidth:Float)
	{
		if (checkWidth>width)
			width=checkWidth;
	}

	public inline function setIfHigherHeight(checkHeight:Float)
	{
		if (checkHeight>height)
			height=checkHeight;
	}

}