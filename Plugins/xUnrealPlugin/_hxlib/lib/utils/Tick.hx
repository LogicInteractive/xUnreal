package lib.utils;

import haxe.Timer;

/**
 * ...
 * @author Tommy S.
 */

class Tick
{
	/////////////////////////////////////////////////////////////////////////////////////

	var callback			: ()->Void;
	var time				: Float;
	var timer				: Timer;

	/////////////////////////////////////////////////////////////////////////////////////
	
	public function new(?callback:()->Void,?time:Null<Float>)
	{
		this.time = time!=null?time:1000/60;
		this.callback = callback;

		if (timer!=null)
			timer.stop();

		timer = new Timer(Std.int(this.time));
		if (this.callback!=null)
			timer.run = this.callback!=null?this.callback:defaultTick;
	}

	function defaultTick()
	{
		if (callback!=null)		
			callback();
	}

	public function stop()
	{
		if (timer!=null)
			timer.stop();

		timer = null;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function idle():Tick
	{
		return new Tick(()->{});
	}

	/////////////////////////////////////////////////////////////////////////////////////
}