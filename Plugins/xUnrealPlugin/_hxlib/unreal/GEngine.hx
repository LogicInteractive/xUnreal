package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;
import unreal.UExposed.Bridge;
// import unreal.UeExt;

@:cppFileCode('
typedef const char* HaxeString;
void logMessage(HaxeString str);
void printToScreen(HaxeString str);
')
class GEngine extends unreal.UExposed implements Bridge
{
	/////////////////////////////////////////////////////////////////////////////////////

	// public static var persistentDownloadDir		: String;
	public static var localDir					: String;

	/////////////////////////////////////////////////////////////////////////////////////

	static public function init(localDir:String)
	{
		haxe.Log.trace = _trace;
		GEngine.localDir = localDir;
	}

	static public function addOnScreenDebugMessage(key:Int=-1, timeToDisplay:Float=5.0,displayColor:Null<UInt>=0xffffff,debugMessage:Any=null,bNewerOnTop:Bool=false,textScale:Float=1.0)
	{
		_printToScreen(Std.string(debugMessage));
	}

	static public function _trace(v:Dynamic, ?infos:Null<haxe.PosInfos>)
	{
		var pre:String ="";
		if (infos!=null)
			pre = infos.className+":"+infos.lineNumber+": ";
		log(v,pre);
	}

	static public function log(value:Any=null,?pre:String)
	{
		// var v:String = Std.string(value);
		// untyped __cpp__('logMessage(v)');
		if (pre==null)
			pre="";
		untyped __global__.logMessage(pre+Std.string(value));
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:native("printToScreen") @:noCompletion
	extern public static function _printToScreen(inp:String):Void;

	// @:native("logMessage") @:noCompletion
	// extern public static function _logMessage(inp:String):Void;

	/////////////////////////////////////////////////////////////////////////////////////
}
