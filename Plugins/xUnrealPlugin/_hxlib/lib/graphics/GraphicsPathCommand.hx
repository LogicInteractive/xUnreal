package lib.graphics;

enum abstract GraphicsPathCommand(Int) to Int
{
	/**
	* Represents the default "do nothing" command.
	*/	
	var NO_OP 					= 0;
	
	/**
	* Specifies a drawing command that moves the current drawing position to the x- and y-coordinates specified in the data array.
	*/	
	var MOVE_TO 				= 1;
	
	/**
	* Specifies a drawing command that draws a line from the current drawing position to the x- and y-coordinates specified in the data array.
	*/	
	var LINE_TO 				= 2;
	
	/**
	* Specifies a drawing command that draws a curve from the current drawing position to the x- and y-coordinates specified in the data array, using a control point.
	*/	
	var CURVE_TO			 	= 3;
	
	/**
	* Specifies a "move to" drawing command, but uses two sets of coordinates (four values) instead of one set.
	*/	
	var WIDE_MOVE_TO			= 4;
	
	/**
	* Specifies a "line to" drawing command, but uses two sets of coordinates (four values) instead of one set.
	*/	
	var WIDE_LINE_TO			= 5;
	
	/**
	* Specifies a drawing command that draws a curve from the current drawing position to the x- and y-coordinates specified in the data array, using a 2 control points.
	*/	
	var CUBIC_CURVE_TO 			= 6;
	
	/**
	*/	
	var LINE		 			= 7;
	
	/**
	*/	
	var END_LINE	 			= 8;
}
