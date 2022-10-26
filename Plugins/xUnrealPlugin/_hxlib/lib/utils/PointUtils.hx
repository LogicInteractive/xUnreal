package lib.utils;


typedef Point =
{
	var x 	: Float;
	var	y	: Float;
}

class PointUtils 
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////////
}
	
class PointOrigin
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	public	var	x 			: Float			= 0;
	public	var	y 			: Float			= 0;
	public	var	z 			: Float			= 0;
	public	var	width		: Float			= 0;
	public	var	height		: Float			= 0;
	public	var	rotation 	: Float			= 0;
	public	var	scale	 	: Float			= 0;
	public	var	scaleX	 	: Float			= 0;
	public	var	scaleY	 	: Float			= 0;

	/////////////////////////////////////////////////////////////////////////////////////
	
	public function new(?props:Dynamic)
	{
		//if (props != null)
			//for (p in props) 
 				//Reflect.setField(this,p
	}
	
	public function toPoint2D():Point 
	{
		return {x:this.x, y:this.y};
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}
	
