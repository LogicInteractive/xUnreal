package lib.utils;
import haxe.Timer;

/**
 * ...
 * @author 
 */
class Sleepy
{
	var prevTime						: Int = 0;
	var step							: Int;
	var ftimer							: Float;
	static inline var TARGET_INTERVAL	: Float = 1000 / 60;

	static var startTime				: Float				= Timer.stamp();
	
	public function new()
	{
		
	}
	
	public function sleepFrame() 
	{
		step = Timer.stamp() - prevTime;
		prevTime += step;
		ftimer = (TARGET_INTERVAL - (Lib.getTimer() - prevTime));
		prevTime = Timer.stamp();
    
		if (ftimer > 0) 
		{
			Sys.sleep( ftimer / 1000 );
		}
	}	
	
	public function sleepHalfFrame() 
	{
		step = Timer.stamp() - prevTime;
		prevTime += step;
		ftimer = ((TARGET_INTERVAL*0.5) - (Lib.getTimer() - prevTime));
		prevTime = Timer.stamp();
    
		if (ftimer > 0) 
		{
			Sys.sleep( ftimer / 1000 );
		}
	}	
}