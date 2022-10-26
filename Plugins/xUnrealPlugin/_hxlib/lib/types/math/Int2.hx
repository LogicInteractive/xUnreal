package lib.types.math;

/**
  Objects of this type represent a 2-dimensional int.
**/
@:structInit
class Int2
{
  public var x:Int;
  public var y:Int;

  static public inline function of(x:Int, y:Int)
  {
    return new Int2(x, y);
  }

  private inline function new(x:Int, y:Int)
  {
    this.x = x;
    this.y = y;
  }

  public inline function sub(v:Int2):Int2
  {
    this.x -= v.x;
    this.y -= v.y;
    return this;
  }

  public inline function add(v:Int2):Int2
  {
    this.x += v.x;
    this.y += v.y;
    return this;
  }

  public inline function scale(s:Int):Int2
  {
    this.x *= s;
    this.y *= s;
    return this;
  }

  public inline function clone()
  {
    return new Int2(x, y);
  }

  public inline function toString():String
  {
    return '($x,$y)';
  }
}
