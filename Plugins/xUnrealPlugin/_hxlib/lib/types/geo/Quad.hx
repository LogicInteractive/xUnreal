package lib.types.geo;

import lib.types.math.Vec;

/**
  Objects of this type represent a quadrilateral.
**/
class Quad
{
  public var topLeft:Vec;
  public var topRight:Vec;
  public var bottomLeft:Vec;
  public var bottomRight:Vec;

  /* Create a new quad given the provided coordinates */
  public inline function new(
    topLeft:Vec,
    topRight:Vec,
    bottomLeft:Vec,
    bottomRight:Vec
  ) {
    this.topLeft = topLeft;
    this.topRight = topRight;
    this.bottomLeft = bottomLeft;
    this.bottomRight = bottomRight;
  }

  public function toQuadBuffer()
  {
    var v:hxd.FloatBuffer = new hxd.FloatBuffer();
    pushVertex(v,bottomLeft, 0, 0);
    pushVertex(v,topLeft, 0, 1);
    pushVertex(v,bottomRight, 1, 0);
    pushVertex(v,topRight, 1, 1);    
    return 
    {
      vertices:v,
      buffer:h3d.Buffer.ofFloats(v, 8, [Quads, RawFormat])
    }    
  }

  static public function toBuffer(topLeft:Vec,topRight:Vec,bottomLeft:Vec,bottomRight:Vec)
  {
    var v:hxd.FloatBuffer = new hxd.FloatBuffer();
    pushVertex(v,bottomLeft, 0, 0);
    pushVertex(v,topLeft, 0, 1);
    pushVertex(v,bottomRight, 1, 0);
    pushVertex(v,topRight, 1, 1);    
    return 
    {
      vertices:v,
      buffer:h3d.Buffer.ofFloats(v, 8, [Quads, RawFormat])
    }
  }

  static private function pushVertex(vertices:hxd.FloatBuffer,p:Vec, u:Float, v:Float)
  {
    vertices.push(p.x); // xy
    vertices.push(p.y);

    vertices.push(u); // uv
    vertices.push(v);

    vertices.push(1.0); // rgba
    vertices.push(1.0);
    vertices.push(1.0);
    vertices.push(1.0);
  }  
}
