package lib.utils;

import haxe.Timer;

class AnimationUtils 
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public function cycleValue(freq:Float=2.0,ampl:Float=1.0,invertPhase:Bool=false):Float
	{
		return invertPhase?((Math.cos(Timer.stamp()*freq)*0.5)+0.5)*ampl:((Math.sin(Timer.stamp()*freq)*0.5)+0.5)*ampl;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}
