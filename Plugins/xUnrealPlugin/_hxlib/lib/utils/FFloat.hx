package lib.utils;

@:structInit
class FFloat 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var values							: Array<Float>		= [];
	public var value	(default, set) 	: Float				= 0.0;
	public var last					 	: Float				= 0.0;

	public function new(factor:Int=10,initialValue:Float=0.0)
	{
		if (factor<1)
			factor = 1;

		values.resize(factor);
		for (i in 0...values.length)
			values[i]=initialValue;
	}
	
 	function set_value(v:Float):Float
	{
		last = v;
		values.shift();
		values.push(v);
		value = 0.0;
		for (i in 0...values.length)
			value+=values[i];
		
		value/=values.length;
		return value;
	}
	
	public function add(val:Float):Float
	{
		return value = val;
	}

	public function setTo(newValue:Float = 0.0)
	{
		for (i in 0...values.length)
			value=newValue;
	}

	public function flatten(flattenValue:Float = 0.0)
	{
		this.value = flattenValue;
	}

	public function dispose()
	{
		values = null;	
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function create(?smoothFactor:Int=20,?initialVal:Float=0):FFloat 
	{
		return new FFloat(smoothFactor, initialVal);
	}

	/////////////////////////////////////////////////////////////////////////////////////
}