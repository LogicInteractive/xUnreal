package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;
// import unreal.UeExt;

@:cppFileCode('
typedef const char* HaxeString;
void logMessage(HaxeString str);
void printToScreen(HaxeString str);
')
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
		_printToScreen(Std.string(debugMessage));
	}

	static public function _trace(v:Dynamic, ?infos:Null<haxe.PosInfos>)
	{
		log(v);
	}

	static public function log(value:Any=null)
	{
		var v:String = Std.string(value);
		untyped __cpp__('logMessage(v)');
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:native("printToScreen") @:noCompletion
	extern public static function _printToScreen(inp:String):Void;

	// @:native("logMessage") @:noCompletion
	// extern public static function _logMessage(inp:String):Void;

	/////////////////////////////////////////////////////////////////////////////////////
}
