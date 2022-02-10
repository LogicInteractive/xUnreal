package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;

class GEngine extends unreal.UExposed
{
	/////////////////////////////////////////////////////////////////////////////////////


	/////////////////////////////////////////////////////////////////////////////////////

	static public function init()
	{
		haxe.Log.trace = _trace;
	}

	static public function addOnScreenDebugMessage(key:Int=-1, timeToDisplay:Float=5.0,displayColor:Null<UInt>=0xffffff,debugMessage:Any=null,bNewerOnTop:Bool=false,textScale:Float=1.0)
	{
		UeExt.printToScreen(Std.string(debugMessage));
	}

	static public function _trace(v:Dynamic, ?infos:Null<haxe.PosInfos>)
	{
		log(v);
	}

	static public function log(value:Any=null)
	{
		UeExt.logMessage(Std.string(value));
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
