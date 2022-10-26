package lib.types.geo;

import lib.types.math.Vec;

/**
  Objects of this type represent a line in 2 dimensions.

  Lines are identified by the start and end points which are represented
  as 2 vecs.
**/
class Line {
  public var start:Vec;
  public var end:Vec;

  /* Create a new line with start and end points. */
  public inline function new(start:Vec, end:Vec) {
    this.start = start;
    this.end = end;
  }

  /**
    Compute the vertices of a quad which is aligned with this line.
    @param width the line's width, can be arbitrarily large
  **/
  public inline function toQuad(width:Float):Quad {
    final half_width = width / 2;

    /* Compute the basis vectors defined by this line */
    final mainAxis = end.clone().sub(start);
    final offAxis = mainAxis.clone().rot90().norm().scale(half_width);

    final topLeft = start.clone().add(offAxis);
    final bottomLeft = start.clone().add(offAxis.scale(-1));
    final topRight = topLeft.clone().add(mainAxis);
    final bottomRight = bottomLeft.clone().add(mainAxis);

    return new Quad(topLeft, topRight, bottomLeft, bottomRight);
  }
}
