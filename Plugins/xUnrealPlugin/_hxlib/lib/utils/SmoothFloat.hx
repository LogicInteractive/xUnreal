package lib.utils;

/**
 * ...
 * @author Tommy S.
 */
class SmoothFloat
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	private var valueList				: Array<Float>;
	private var numValues				: Int				= 0;
	private var vIndex					: Int				= 0;
	
	private	var smoothing				: Int 				= 20;
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function new(?smoothFactor:Int=20,?initialVal:Float=0) 
	{
		this.valueList = [];
		this.numValues = smoothFactor;
		
		if (smoothFactor < 1)
			smoothFactor = 1;
			
		for (i in 0...smoothFactor) 
		{
			valueList.push(initialVal);
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	private function getSmoothedValue():Float
	{
		var smVal:Float = 0;
		for (i in 0...numValues) 
		{
			smVal += valueList[i];
		}
		return smVal / numValues;
	}
	
	@:isVar 
	public var value(get,null):Float;
	function get_value():Float
	{
		return getSmoothedValue();
	}
	
	public function add(val:Float):Float
	{
		valueList[vIndex] = val;
		vIndex++;
		if (vIndex >= numValues)
			vIndex = 0;
			
		return getSmoothedValue();
	}
	
	public function setTo(val:Float) 
	{
		for (i in 0...numValues) 
		{
			valueList[i] = val;
		}
	}
	
	public function setSmoothing(smoothFactor:Int=20) 
	{
		var curval = getSmoothedValue();
		
		this.valueList = [];
		this.numValues = smoothFactor;
		
		if (smoothFactor < 1)
			smoothFactor = 1;
			
		for (i in 0...smoothFactor) 
		{
			valueList.push(curval);
		}
		return smoothing = smoothFactor;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function dispose()
	{
		this.valueList = null;
	}
	
	static public inline function create(?smoothFactor:Int=20,?initialVal:Float=0):SmoothFloat 
	{
		return new SmoothFloat(smoothFactor, initialVal);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}
