package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;
import lib.kontentum.Kontentum;
import lib.loader.Loader;
import unreal.Actor.ActorPtr;
import unreal.UExposed.Bridge;
// import unreal.UeExt;

@:cppFileCode('
typedef const char* HaxeString;
void logMessage(HaxeString str);
void printToScreen(HaxeString str, float timeToDisplay);
void _callGlobalEvent(HaxeString EventName, HaxeString Payload);
')
class GEngine extends UObjectBase implements Bridge
{
	/////////////////////////////////////////////////////////////////////////////////////

	// public static var persistentDownloadDir		: String;
	public static var localDir					: String;

	/////////////////////////////////////////////////////////////////////////////////////

	static public function init(localDir:String)
	{
		haxe.Log.trace = _trace;
		GEngine.localDir = localDir;
		Loader.appFolder = localDir;
	}

	static public function addOnScreenDebugMessage(debugMessage:Any=null, timeToDisplay:Float=5.0, key:Int=-1, displayColor:Null<UInt>=0xffffff,bNewerOnTop:Bool=false,textScale:Float=1.0)
	{
		_printToScreen(Std.string(debugMessage),timeToDisplay);
	}

	static public function _trace(v:Dynamic, ?infos:Null<haxe.PosInfos>)
	{
		var pre:String ="";
		if (infos!=null)
			pre = infos.className+":"+infos.lineNumber+": ";

		var out:String = '';
		out+=Std.string(v);
		if (infos.customParams!=null)
		{
			for (i in 0...infos.customParams.length)
				out+=','+Std.string(infos.customParams[i]);
		}

		log(out,pre);
	}

	static public function log(value:Any=null,?pre:String)
	{
		// var v:String = Std.string(value);
		// untyped __cpp__('logMessage(v)');
		if (pre==null)
			pre="";
		untyped __global__.logMessage(pre+Std.string(value));
	}

	static public function dispatchEvent(?eventName:String="", ?payload:String)
	{
		untyped __global__._callGlobalEvent(eventName,payload);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:native("printToScreen") @:noCompletion
	extern public static function _printToScreen(inp:String,timeToDisplay:Float):Void;

	// @:native("_callGlobalEvent") @:noCompletion
	// extern public static function dispatchEvent(?eventName:String=""):Void;

	// @:native("logMessage") @:noCompletion
	// extern public static function _logMessage(inp:String):Void;

	/////////////////////////////////////////////////////////////////////////////////////

	@:expose @:noCompletion
	static public function receiveGlobalEvent(eventName:String,payload:String)
	{
		trace('Got Event: $eventName | $payload');
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
