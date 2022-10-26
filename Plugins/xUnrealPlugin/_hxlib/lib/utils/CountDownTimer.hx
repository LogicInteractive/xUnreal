package lib.utils;

import haxe.Constraints.Function;
import haxe.Timer;

/**
 * ...
 * @author Tommy S
 */

typedef CountDownTriggerTime =
{
	
	@:optional	var triggerTime			: Int;
	@:optional	var callBack			: Function;
	
}
 
class CountDownTimer
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	public var autoDispose			: Bool				= true;
	public var repeat				: Bool;
	public var isRunning			: Bool;
	public var isPaused				: Bool;
	public var time					: Float				= 60*3;
	public var timePassed			: Float				= 0;
	public var timeRemaining		: Float				= 0;
	
	public var onSecond(default,set): Function;
	public var onComplete			: Function;
	
	private var secTimerID			: UInt;
	private var triggerList			: Array<CountDownTriggerTime>;
	var timer						: Timer;

	/////////////////////////////////////////////////////////////////////////////////////
		
	public function new(timeInSeconds:Float, autoStart:Bool=true, autoDispose:Bool=true)
	{
		this.time = timeInSeconds;
		this.autoDispose = autoDispose;
		triggerList = [];
		timeRemaining = this.time;
		onSec();
		if (autoStart)
			start();
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function start()
	{
		if (!isRunning)
		{
			timeRemaining = this.time;
			onSec();
			isRunning = true;
			timer = new Timer(1000);
			timer.run = onSec;
		}
		else if (isPaused)
		{
			resume();
		}
	}
	
	public function stop() 
	{
		if (isRunning)
		{
			if (timer != null)
				timer.stop();
			isRunning = false;
		}
	}
	
	public function pause() 
	{
		if (isRunning)
		{
			isPaused = true;
		}
	}

	public function resume() 
	{
		if (isRunning && isPaused)
		{
			isPaused = false;
		}
	}

	public function restart() 
	{
		if (timer != null)
			timer.stop();
		timePassed = 0;
		isRunning = true;
		timeRemaining = this.time;
		timer = new Timer(1000);
		timer.run = onSec;
		onSec();
	}
	
	private function onSec() 
	{
		if (triggerList!=null && (!isPaused))
		{
			if (isRunning)
				timePassed++;
			
			timeRemaining = time-timePassed;
			
			if (onSecond!=null)
				onSecond(this);

			for (i in 0...triggerList.length) 
			{
				if (timePassed == triggerList[i].triggerTime)
				{
					if (triggerList[i].callBack!=null)
						triggerList[i].callBack(this);
				}
			}
				
			if (timePassed >= time)
				isComplete();
		}
	}
	
	private function isComplete() 
	{
		if (!repeat)
		{
			if (timer != null)
				timer.stop();
				
			var cmp = onComplete;

			if (autoDispose)
				dispose();

			if (cmp!=null)
				cmp(this);
		}
		else
		{
			timePassed = 0;
			if (onComplete!=null)
				onComplete(this);
		}

	}
		
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function addTrigger(timeInSeconds:Int, callBack:Void->Void)
	{
		var tt:CountDownTriggerTime = {};
		tt.triggerTime = timeInSeconds;
		tt.callBack = callBack;
		triggerList.push(tt);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public function getHHMMSSremaining():String
	{
		return TimeUtils.convertToHHMMSS(time - timePassed);
	}
	
	public function getHHMMSSpassed():String
	{
		return TimeUtils.convertToHHMMSS(timePassed);
	}

	public function gettimePassedNormalized():Float
	{
		return timePassed/time;
	}

	public function getHHMMSStotalTime():String
	{
		return TimeUtils.convertToHHMMSS(time);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function set_onSecond(f:Function):Function
	{
		if (f!=null)
			f(this);
		return onSecond = f;
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
	public function dispose() 
	{
		stop();
		isPaused = false;
		timer = null;
		if (triggerList!=null)
		{
			for (t in triggerList)
				t.callBack = null;
			triggerList.resize(0);
		}
		triggerList = null;
		timePassed = 0;
		onSecond=null;
		onComplete=null;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}





















/*





package no.logic.uix.system.utils
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	public class CountDownTimer
	{
		/////////////////////////////////////////////////////////////////////////////////////
		
		//===================================================================================
		// Consts 
		//-----------------------------------------------------------------------------------
		
		//===================================================================================
		// Properties 
		//-----------------------------------------------------------------------------------
		
		public var autoDispose			: Boolean			= true;
		public var repeat				: Boolean;
		public var isRunning			: Boolean;
		public var isPaused				: Boolean;
		public var time					: int				= 60*3;
		public var timePassed			: int				= 0;
		public var timeRemaining		: int				= 0;
		
		//===================================================================================
		// Declarations 
		//-----------------------------------------------------------------------------------

		//===================================================================================
		// Callbacks 
		//-----------------------------------------------------------------------------------		
		
		public var onSecond				: Function;
		public var onComplete			: Function;
		
		//===================================================================================
		// Variables 
		//-----------------------------------------------------------------------------------		
		
		private var secTimerID			: uint;
		private var triggerList			: Vector.<CountDownTriggerTime>;

		/////////////////////////////////////////////////////////////////////////////////////

		public function CountDownTimer(timeInSeconds:int, autoStart:Boolean=true, autoDispose:Boolean=true):void
		{
			this.time = timeInSeconds;
			this.autoDispose = autoDispose;
			triggerList = new <CountDownTriggerTime>[];
			if (autoStart)
				start();
		}
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		public function start():void
		{
			if (!isRunning)
			{
				isRunning = true;
				timeRemaining = this.time;
				secTimerID = setInterval(onSec, 1000);
			}
			else if (isPaused)
			{
				resume();
			}
		}
		
		public function stop():void 
		{
			if (isRunning)
			{
				clearInterval(secTimerID);			
				isRunning = false;
			}
		}
		
		public function pause():void 
		{
			if (isRunning)
			{
				isPaused = true;
			}
		}

		public function resume():void 
		{
			if (isRunning && isPaused)
			{
				isPaused = false;
			}
		}

		public function restart():void 
		{
			clearInterval(secTimerID);					
			timePassed = 0;
			isRunning = true;
			timeRemaining = this.time;
			secTimerID = setInterval(onSec, 1000);
		}
		
		private function onSec():void 
		{
			if (triggerList && (!isPaused))
			{
				timePassed++;
				timeRemaining = time-timePassed;
				
				if (onSecond is Function)
					onSecond()
					
				for (var i:int = 0; i < triggerList.length; i++) 
				{
					if (timePassed == triggerList[i].triggerTime)
					{
						if (triggerList[i].callBack is Function)
							triggerList[i].callBack()
					}
				}
					
				if (timePassed >= time)
					isComplete()
			}
		}
		
		private function isComplete():void 
		{
			if (!repeat)
			{
				clearInterval(secTimerID);
				if (autoDispose)
					dispose();
			}
			else
			{
				timePassed = 0;
			}

			if (onComplete is Function)
				onComplete()
		}
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		public function addTrigger(timeInSeconds:int, callBack:Function):void
		{
			var tt:CountDownTriggerTime = new CountDownTriggerTime;
			tt.triggerTime = timeInSeconds;
			tt.callBack = callBack;
			triggerList.push(tt);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		public function get HHMMSSremaining():String
		{
			return TimeUtils.convertToHHMMSS(time - timePassed);
		}
		
		public function get HHMMSSpassed():String
		{
			return TimeUtils.convertToHHMMSS(timePassed);
		}

		public function get timePassedNormalized():Number
		{
			return timePassed/time;
		}

		public function get HHMMSStotalTime():String
		{
			return TimeUtils.convertToHHMMSS(time);
		}

		/////////////////////////////////////////////////////////////////////////////////////
		
		public function dispose():void 
		{
			isRunning = false;
			isPaused = false;
			clearInterval(secTimerID);
			triggerList = null;
			timePassed = 0;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////
	}
}

	internal class CountDownTriggerTime
	{
		
		public var triggerTime			: int;
		public var callBack				: Function;
		
	}
	
	*/