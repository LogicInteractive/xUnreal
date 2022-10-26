package lib.utils;

import haxe.Timer;

class TimeTrack 
{
	/////////////////////////////////////////////////////////////////////////////////////

	static var time			: Map<String,TimeRecord> = new Map<String,TimeRecord>();

	static public inline function start(id:String="default")
	{
		// time=System.time;
		time.set(id,{start:Timer.stamp(),stop:0,time:0});
	}
	
	static public inline function stop(id:String="default",returnAsSeconds:Bool=false):Float
	{
		if (!time.exists(id))
			return 0;

		time.get(id).stop = Timer.stamp();
		time.get(id).time = time.get(id).stop-time.get(id).start;
		if (!returnAsSeconds)
			return time.get(id).time*1000;
		else
			return time.get(id).time;
	}
	
	
	static public inline function get(id:String="default",returnAsSeconds:Bool=false):Float
	{
		if (!time.exists(id))
			return 0;

		if (!returnAsSeconds)
			return time.get(id).time*1000;
		else
			return time.get(id).time;
	}
	
	static public inline function ping(id:String="default",returnAsSeconds:Bool=false):Float
	{
		var r = 0.0;
		if (time.exists(id))
			r = stop(id,returnAsSeconds);

		start(id);
		return r;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public function radix( number : Float, precision : Int=4): String
	{
		var num = number * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		var s = Std.string(num);
		var d2 = s.split(".");
		if (d2!=null && d2.length==2)
		{
			if (d2[1].length==3)
				s+="0";
			else if (d2[1].length==2)
				s+="00";
			else if (d2[1].length==1)
				s+="000";
		}
		return s;
	}	
	/////////////////////////////////////////////////////////////////////////////////////
}

typedef TimeRecord =
{
	var start	: Float;
	var stop	: Float;
	var time	: Float;
}