package lib.types.math;

@:structInit
class Float2
{
  
  @:optional public var x:Float     = 0.0;
  @:optional public var y:Float     = 0.0;

  static public inline function of(x:Float, y:Float):Float2
  {
    return {x:x, y:y};
  }

  // private inline function new(x:Float, y:Float)
  // {
  //   this.x = x;
  //   this.y = y;
  // }

  public inline function sub(v:Float2):Float2
  {
    this.x -= v.x;
    this.y -= v.y;
    return this;
  }

  public inline function add(v:Float2):Float2
  {
    this.x += v.x;
    this.y += v.y;
    return this;
  }

  public inline function scale(s:Float):Float2
  {
    this.x *= s;
    this.y *= s;
    return this;
  }

  public inline function clone():Float2
  {
    return {x:x, y:y};
  }
}
