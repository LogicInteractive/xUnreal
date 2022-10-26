package lib.utils;

@:structInit
class HistoryFloat
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	var history		: Array<Float>;
	public var length		: Int;
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function new(length:Int=5)
	{
		this.length = length;
		history = [];
		history.resize(length);
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
	public function add(value:Float):Float
	{
		history.insert(0, value);
		if (history.length >= length)
			history.resize(length);
		return get();
	}
	
	public function delta(indexA:Int,indexB:Int):Float
	{
		return getNewest(indexA)-getNewest(indexB);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function get():Float
	{
		return history[history.length - 1];
	}
	
	public function getNewest(fromTop:Int=0):Float
	{
		return history[fromTop];
	}

	public function getOldest(fromBottom:Int=0):Float
	{
		var ci = (history.length-1)-fromBottom;
		if (ci<0)
			ci = 0;
		return history[ci];
	}
	
	public function getHistory():Array<Float>
	{
		return history;
	}
	
	public function getAverage():Float
	{
		if (length==0)
			return 0;
			
		var avg:Float = 0;
		for (h in history)
			avg+=h;
		return avg/length;
	}
	
	public function getMax():Float
	{
		if (length==0)
			return 0;

		var m:Float = 0;
		for (h in history)
			h>m?m=h:null;
		return m;
	}
	
	public function getMin():Float
	{
		if (length==0)
			return 0;

		var m:Float = Math.POSITIVE_INFINITY;
		for (h in history)
			h<m?m=h:null;
		return m;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function clear()
	{
		history = [];
	}
	
	public function dispose()
	{
		history = null;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}