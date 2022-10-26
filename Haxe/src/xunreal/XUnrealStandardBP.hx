package xunreal;

import lib.loader.Loader;
import lib.types.Object;
import lib.utils.ObjUtils;
import lib.utils.MathUtils;
import lib.utils.StringUtils;
import lib.utils.TimeUtils;
import unreal.*;

@:keep
class XUnrealStandardBP extends unreal.BlueprintFunctionLibrary
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public var configXML			: String;
	static public var config			: Object;

	/////////////////////////////////////////////////////////////////////////////////////

	@:ufunction(BlueprintCallable, Category="xUnreal")
	static public function Trace(input:String)
	{
		trace(input);
	}	

	@:ufunction(BlueprintCallable, Category="xUnreal", meta = (ReturnDisplayName = "XML string"))
	static public function loadConfigXML(?optionalFileName:String):String
	{
		if (optionalFileName==null || optionalFileName=="" || optionalFileName==" ")
			optionalFileName = "config.xml";

		var onConfigLoadDone = ()->
		{
			trace("Config loaded !!!!!");
			return configXML;
		}

		Loader.LoadXML(GEngine.localDir+"/"+optionalFileName,null,
		(l:Loader)->
		{
			configXML = Std.string(l.contentRAW);
			try
			{
				config = ObjUtils.fromXML(l.contentXML,true);
				onConfigLoadDone();
			}
			catch(e:haxe.Exception)
			{
				trace("Error : Error in config.xml");
				trace(l.contentRAW);
				onConfigLoadDone();
			}
		},
		(l:Loader)->
		{
			trace("Config XML failed to load! ("+l.source+")");
			onConfigLoadDone();
		}); 

		return null;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:ufunction(BlueprintCallable, BlueprintPure, Category="xUnreal", meta = (ReturnDisplayName = "Config"))
	static public function getConfig():Dynamic
	{
		return config;
	}

	@:ufunction(BlueprintCallable, BlueprintPure, Category="xUnreal", meta = (ReturnDisplayName = "String"))
	static public function getStringFromConfig(path:String):String
	{
		return cast ObjUtils.getFieldByObjectPath(config,path);
	}

	@:ufunction(BlueprintCallable, BlueprintPure, Category="xUnreal", meta = (ReturnDisplayName = "Int"))
	static public function getIntFromConfig(path:String):Int
	{
		return cast ObjUtils.getFieldByObjectPath(config,path);
	}

	@:ufunction(BlueprintCallable, BlueprintPure, Category="xUnreal", meta = (ReturnDisplayName = "Float"))
	static public function getFloatFromConfig(path:String):Float
	{
		return cast ObjUtils.getFieldByObjectPath(config,path);
	}

	@:ufunction(BlueprintCallable, BlueprintPure, Category="xUnreal", meta = (ReturnDisplayName = "Bool"))
	static public function getBoolFromConfig(path:String):Bool
	{
		return cast ObjUtils.getFieldByObjectPath(config,path);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:ufunction(BlueprintCallable, Category="xUnreal")
	static public function setObject(object:Dynamic)
	{
		trace("got an object?");
		trace(object);
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

