package lib.types;

import lib.utils.DateUtils;
import lib.utils.StringUtils;
import lib.utils.TimeUtils;

@:structInit
class TimeData
{
	/////////////////////////////////////////////////////////////////////////////////////

	public var frames			: UInt			= 0;
	public var milliseconds		: Int			= 0;
	public var seconds			: Int			= 0;
	public var minutes			: Int			= 0;
	public var hours			: Int			= 0;
	public var days				: Int			= 0;
	// public var months			: Int			= 0;
	// public var years			: Int			= 0;

	/////////////////////////////////////////////////////////////////////////////////////

	public function new(seconds:Int=0,minutes:Int=0,hours:Int=0)
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////

	public function reset()
	{
		frames = 0;
		milliseconds = 0;
		seconds = 0;
		minutes = 0;
		hours = 0;
		days = 0;
		// months = 0;
		// years = 0;
	}

	public function fromElapsedSeconds(elapsedSeconds:Float)
	{
		if (elapsedSeconds==0)
		{
			reset();
			return;
		}
		seconds = Math.floor(elapsedSeconds);
		milliseconds = Math.round((elapsedSeconds-seconds)*1000);
		minutes = Math.floor(seconds/60);		
		hours = Math.floor(minutes/60);		
		days = Math.floor(hours/24);		
	}

	public function fromElapsedMS(elapsedMilliseconds:Int)
	{
		if (elapsedMilliseconds==0)
		{
			reset();
			return;
		}
		seconds = Math.floor(elapsedMilliseconds*0.001);
		milliseconds = elapsedMilliseconds;
		minutes = Math.floor(seconds/60);		
		hours = Math.floor(minutes/60);		
		days = Math.floor(hours/24);		
	}

	public function toHHMMSS():String
	{
		return TimeUtils.convertToHHMMSS(seconds);
	}

	public function toMMSS():String
	{
		return TimeUtils.convertToMMSS(seconds);
	}

	/////////////////////////////////////////////////////////////////////////////////////
}