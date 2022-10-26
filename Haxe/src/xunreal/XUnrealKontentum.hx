package xunreal;

import lib.kontentum.KontentumDataTypes.KontentumFile;
import lib.kontentum.KontentumDataTypes.KontentumLanguage;
import lib.utils.MathUtils;
import lib.utils.StringUtils;
import lib.utils.TimeUtils;
import lib.kontentum.Kontentum;
import unreal.*;

@:keep
class XUnrealKontentum extends unreal.BlueprintFunctionLibrary
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	@:ufunction(BlueprintCallable, Category="xUnreal|Kontentum")
	static public function setKontentumLanguage(lang:String)
	{
		if (lang=="en" || lang =="eng")
		{
			Kontentum.currentLanguage = KontentumLanguage.EN;
		}
		else
		{
			Kontentum.currentLanguage = KontentumLanguage.NO;
		}
	}	

	@:ufunction(BlueprintPure, Category="xUnreal|Kontentum")
	static public function KontentumHasData():Bool
	{
		return Kontentum.hasData;
	}	

	@:ufunction(BlueprintPure, Category="xUnreal|Kontentum")
	static public function KontentumRestJsonString():String
	{
		return Kontentum.RESTJsonStr;
	}	

	@:ufunction(BlueprintPure, Category="xUnreal|Kontentum")
	static public function KontentumGetText(id:String):String
	{
		return Kontentum.getText(id);
	}	

	@:ufunction(BlueprintPure, Category="xUnreal|Kontentum")
	static public function KontentumGetFile(id:String):String
	{
		var kf:KontentumFile = Kontentum.getFile(id);
		if (kf!=null)
			return Kontentum.getFile(id).file;
		else
			return null;
	}	

	// @:ufunction(BlueprintCallable, Category="IO")
	// static public function setAppDate()
	// {
	// 	var bd:String = TimeUtils.getFormatedDayTimeStamp(DataManager.buildDate,true).split("/").join(".");
	// 	var submitStr:String = '$bd';
	// 	Kontentum.submitClientInfo(submitStr);
	// }

	/////////////////////////////////////////////////////////////////////////////////////
}

/*


	static public var isRunning		: Bool;
	static public var configXML		: String;
	static public var config		: Object;

	/////////////////////////////////////////////////////////////////////////////////////

    public static function init()
	{
		if (!isRunning)
	        start();
		else 
			reset();
    }

	/////////////////////////////////////////////////////////////////////////////////////

	static function start()
	{
		Loader.LoadXML(GEngine.localDir+"/config.xml",null,
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
	}

	static function onConfigLoadDone()
	{
		if (config!=null)
		{
			isRunning = true;
			Kontentum.onComplete=onKontentumReady;
			Kontentum.onFail=(status:KontentumStatus)->
			{
				trace("Connection to Kontentum failed.",true);
				trace(status);
			};

			if (config.kontentum.clientID!=null)
				Kontentum.clientID = Std.string(config.kontentum.clientID);

			Kontentum.connect(
				config.kontentum.token,
				config.kontentum.ip,
				config.kontentum.localFiles,
				false,
				false,
				false,
				true,
				null
			);

		}
	}

	static function onKontentumReady()
	{
		DataManager.init();		
	}

	static public function reset()
	{
		DataManager.reset();
		TrailApi.reset();
	}

	/////////////////////////////////////////////////////////////////////////////////////

	*/