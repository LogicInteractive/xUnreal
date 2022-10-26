package lib.kontentum;

import haxe.Timer;
import haxe.crypto.Base64;
import lib.kontentum.KontentumDataTypes.KontentumExhibitInfo;
import lib.kontentum.KontentumDataTypes.KontentumExhibitJSON;
import lib.kontentum.KontentumDataTypes.KontentumExhibitLanguage;
import lib.kontentum.KontentumDataTypes.KontentumExhibitTextEntry;
import lib.kontentum.KontentumDataTypes.KontentumFile;
import lib.kontentum.KontentumDataTypes.KontentumLanguage;
import lib.kontentum.KontentumDataTypes.KontentumStatus;
import lib.kontentum.KontentumDataTypes.KontentumText;
import lib.loader.FileCache;
import lib.loader.Loader;
import lib.types.Object;
import lib.utils.Convert;
import lib.utils.DateUtils;
import lib.utils.ObjUtils;
import lib.utils.StringUtils;

class Kontentum
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline var LANGUAGE_CHANGED: String					= "kontentum_language_changed";		

	/////////////////////////////////////////////////////////////////////////////////////
	
	static public var rest_ip						: String			= "";
	static public var rest_path						: String			= "rest/getExhibit";
	static public var rest_ping						: String			= "rest/pingExhibit";
	static public var rest_clientInfo				: String			= "rest/setClientInfo";
	static public var remoteFilePath				: String			= "filevault";
	static public var localFileDir					: String			= "";
	static public var exhibitToken					: String			= '';
	static public var clientID						: String			= '';			
	static public var initiated						: Bool;
	static public var preloadImages					: Bool;
	static public var downloadFiles					: Bool;
	static public var downloadFilesProgressString 	: String			= "";
	static public var liveupdate					: Null<Bool>;
	static public var forceRebuildCache				: Bool				= false;
	static public var forceDownloadAllFiles			: Bool				= false;
	
	static public  var fullURL						: String;
	static public  var fileURL						: String;
	static public  var pingURL						: String;
	static var previousTimeStamp					: Int;
	static var pingTime								: Int				= 1000;
	static var pingTimer							: Timer;
	
	static public var apiKey						: String			= "";

	static public var RESTJson						: KontentumExhibitJSON;
	static public var RESTJsonStr					: String;
	static public var assetsLoaded					: Bool;
	static var usingLocalJsonFile					: Bool;
	
	static public var exhibit						: KontentumExhibitInfo;
	static public var languages						: Map<KontentumLanguage,String>;
	static public var texts							: Array<KontentumText>;
	static public var textsByIdentifier				: Map<String,KontentumText>;
	static public var textsIdIdentifier				: Map<Int,KontentumText>;
	static public var files							: Array<KontentumFile>;
	static public var filesByIdentifier				: Map<String,KontentumFile>;
	static public var filesIdIdentifier				: Map<Int,KontentumFile>;
	static public var content						: Dynamic;
	static public var variables						: Dynamic;
	static public var hasData						: Bool				= false;
		
	//public var downloadedFiles		: Files;
	//public var selectedFiles		: Files;

	static public var multipleScoresArray			: Array<String>		= [];	
	
	static public var currentLanguage(default, set) : KontentumLanguage;

	static var fileDownloader						: Loader;
	static var pingLoader							: Loader;
	static public var onComplete					: ()->Void;
	static public var onFail						: (KontentumStatus)->Void;
	// static public var onDownloadFilesProgress		: ()->Void;
	// static public var onDownloadFilesItemComplete	: ()->Void;
	// static public var onPreloadFilesStarted			: (Dynamic)->Void;
	// static public var onPreloadFilesProgress		: (Dynamic)->Void;
	// static public var onPreloadFilesItemComplete	: (Dynamic)->Void;
		
	/////////////////////////////////////////////////////////////////////////////////////
	
	static public function connect(exhibitToken:String, ip:String="https://kontentum.link", ?localFileDir:String=null, ?downloadFiles:Bool=false, ?preloadImages:Bool=false, ?liveupdate:Null<Bool>, ?autoStart:Bool=true, ?connectIP:String=null):Class<Kontentum>
	{
		Kontentum.initiated = true;
		Kontentum.rest_ip = ip;
		Kontentum.exhibitToken = exhibitToken;		
		Kontentum.downloadFiles = downloadFiles;
		Kontentum.preloadImages = preloadImages;
		Kontentum.localFileDir = localFileDir;
		if (liveupdate!=null)
			Kontentum.liveupdate = liveupdate;
		
/*		if (localFileDir == "" || localFileDir == " " || localFileDir == "[object Object]" )  //hjo..hum...
		{
			this.localFileDir = null;
			UIX.assets.localFileDir = "";
		}
		else
		{
			this.localFileDir = localFileDir;
			UIX.assets.localFileDir = this.localFileDir;
		}*/

		if (connectIP!=null)
			fullURL = connectIP;
		else
			fullURL = rest_ip + "/" + rest_path + "/" + exhibitToken + "/" + Convert.toBool(forceRebuildCache) + "/" + Convert.toBool(forceDownloadAllFiles);

		fileURL = rest_ip + "/" + remoteFilePath + "/";
		
		if (autoStart)
			fetch();
		return Kontentum;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	static public function fetch(?fetchComplete:(Loader)->Void,?fetchFailed:(Loader)->Void)
	{
		if (exhibitToken==null || Kontentum.exhibitToken=="")
			return;
			
		usingLocalJsonFile = false;
		Loader.LoadJSON(fullURL, onRestJSONLoaded,(uxl:Loader)->
		{
			if (onFail!=null)
				onFail(KontentumStatus.FailedToGetJSONRest);
			
		// 	var localFile = localFileDir + "/exhibit" + exhibitToken + ".json";
		// 	usingLocalJsonFile = true;

		// 	trace("Kontentum connection failed, trying cache : "+localFile);
		// 	Loader.LoadJSON(localFile, null, onRestJSONLoaded, function(uxl:Loader)
		// 	{
		// 		trace("Local cache not found - Kontentum json failed to load.");

		// 		if (onFail!=null)
		// 			onFail(KontentumStatus.FailedToGetJSONRest);

		},{async:false});
		// Loader.LoadJSON(fullURL, null, restLoaded!=null?restLoaded:onRestJSONLoaded, restFailed!=null?restFailed:function(uxl:Loader)
		// {
		// 	if (onFail!=null)
		// 		onFail(KontentumStatus.FailedToGetJSONRest);
			
		// 	var localFile = localFileDir + "/exhibit" + exhibitToken + ".json";
		// 	usingLocalJsonFile = true;

		// 	trace("Kontentum connection failed, trying cache : "+localFile);
		// 	Loader.LoadJSON(localFile, null, onRestJSONLoaded, function(uxl:Loader)
		// 	{
		// 		trace("Local cache not found - Kontentum json failed to load.");

		// 		if (onFail!=null)
		// 			onFail(KontentumStatus.FailedToGetJSONRest);
		// 	});
		// });
	}	
		
	static function onRestJSONLoaded(uxl:Loader)
	{
		RESTJsonStr = uxl.contentTEXT;
		RESTJson = cast uxl.contentJSON;
		if (RESTJson!=null)
		{
			trace('Kontentum data for exhibit "$exhibitToken" loaded.');
			exhibit = RESTJson.exhibit;
			if (Reflect.hasField(RESTJson.exhibit,'blacklist'))
			{
				var blacklist:Array<String> = RESTJson.exhibit.blacklist;
				for (i in 0...blacklist.length)
				{
					var encoded:String = blacklist[i];
					var decoded:String = cast Base64.decode(encoded);
					blacklist[i] = decoded;
				}
				exhibit.blacklist = blacklist;
			}

			// if (liveupdate==null)
				// liveupdate = exhibit.liveupdate;
				
			content 	= RESTJson.content;
			languages 	= processLanguages();
			texts 		= processTexts();
			files 		= processFiles();
			// variables = processVariables(exhibit.variables);
			
			// Stage.bind.assets.setAssetContent();
			
			// trace(RESTJson);

			pingURL = rest_ip + "/" + rest_ping + "/" + exhibitToken;
			
/*			if (this.localFileDir == null)
			{
				//UIXGuiScanner.localFilePath = fileURL;
				checkPreload();
			}
			else if (downloadFiles)
				downloadAllFiles(this.localFileDir);
			else
			{
				//var fd:String = (localFileDir + "/").split("\"").join("/");
				//UIXGuiScanner.localFilePath = fd;					
				checkPreload();
			}*/

			hasData = true;

			// if (localFileDir != null && downloadFiles)
			// 	downloadAllFiles(localFileDir);
			// else 
			assetsFetched();			

		}
		else
		{
			trace("Kontentum Error: Cant parse JSON");
		}
	}

	static function assetsFetched()
	{
		// if (!usingLocalJsonFile && liveupdate!=null && liveupdate==true)
			// startPing();
			
		// if (preloadImages)
			// preloadAssets();
		// else 
			kontentumReady();		
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	static function processLanguages():Map<KontentumLanguage,String> 
	{
		var langs:Map<KontentumLanguage,String> = new Map<KontentumLanguage,String>();
		if (RESTJson.languages!=null && RESTJson.languages.length>0)
		{
			for (l in RESTJson.languages)
				langs.set(getLangType(l.identifier),l.label);

			currentLanguage = getLangType(RESTJson.languages[0].identifier);				
		}
		return langs;
	}
	
	static public function getLangType(langStr:String):KontentumLanguage
	{
		if (langStr == null)
			return currentLanguage;
			
		var fLang = KontentumLanguage.NO;	
		
		switch (langStr.toLowerCase()) 
		{
			case "no" | "nor":
				fLang = KontentumLanguage.NO;
			case "en" | "eng":
				fLang = KontentumLanguage.EN;
			case "sw" | "swe":
				fLang = KontentumLanguage.SE;
			case "dk":
				fLang = KontentumLanguage.DK;
		}
		
		return fLang;
	}
	
	static public function getLangStr(lang:KontentumLanguage):String
	{
		var langStr = null;
		
		switch (lang) 
		{
			case KontentumLanguage.NO:		langStr = "no";
			case KontentumLanguage.EN:		langStr = "en";
			case KontentumLanguage.SE:		langStr = "se";
			case KontentumLanguage.DK:		langStr = "dk";
			case KontentumLanguage.CURRENT:	langStr = null;
		}
		
		return langStr;
	}

	static public function toggleLanguage(langA:KontentumLanguage,langB:KontentumLanguage)
	{
		if (Kontentum.currentLanguage == langA)
			Kontentum.currentLanguage = langB;
		else
			Kontentum.currentLanguage = langA;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	static function processTexts():Array<KontentumText> 
	{
		var tx:Array<KontentumText> = [];
		if (RESTJson.texts!=null)
		{
			for (t in RESTJson.texts)
			{
				var txs:Map<KontentumLanguage,String> = new Map<KontentumLanguage,String>();
				if (t.text!=null)
				{
					for (txl in Reflect.fields(t.text))
					{
						txs.set(getLangType(txl),Reflect.field(t.text,txl));
					}
				}
				tx.push({
					id: t.id,
					identifier: t.identifier,
					texts: txs,
				});
			}
		}

		textsByIdentifier = new Map<String,KontentumText>();
		textsIdIdentifier = new Map<Int,KontentumText>();

		for (t in tx)
		{
			if (t.identifier!=null && t.identifier!="")
				textsByIdentifier.set(t.identifier,t);
			textsIdIdentifier.set(t.id,t);
		}
		return tx;
	}
	
	static function processFiles():Array<KontentumFile> 
	{
		var fl:Array<KontentumFile> = [];
		if (RESTJson.files!=null)
		{
			for (f in RESTJson.files)
			{
				fl.push({
					id: Std.parseInt(f.id),
					identifier: f.identifier,
					filename: f.filename,
					file: f.file,
					type: f.type,
					title: f.title,
					description: f.description,
					credit: f.credit,
					modified: f.modified,
				});
			}
		}

		filesByIdentifier = new Map<String,KontentumFile>();
		filesIdIdentifier = new Map<Int,KontentumFile>();

		for (f in fl)
		{
			if (f.identifier!=null && f.identifier!="")
				filesByIdentifier.set(f.identifier,f);
			filesIdIdentifier.set(f.id,f);
		}
		return fl;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public overload extern inline function getText(id:Int,?language:KontentumLanguage):String
	{
		var tx:String = null;
		if (textsIdIdentifier==null)
			return tx;

		if (language==null)
			language = currentLanguage;
		
		if (textsIdIdentifier.exists(id))
		{
			var kt = textsIdIdentifier.get(id);
			if (kt!=null && kt.texts!=null)
				tx = kt.texts.get(language);
		}
		return tx;
	}

	static public overload extern inline function getText(identifier:String,?language:KontentumLanguage):String
	{
		var tx:String = null;
		if (textsByIdentifier==null)
			return tx;

		if (language==null)
			language = currentLanguage;
		
		if (textsByIdentifier.exists(identifier))
		{
			var kt = textsByIdentifier.get(identifier);
			if (kt!=null && kt.texts!=null)
				tx = kt.texts.get(language);
		}

		return tx;
	}

	static public overload extern inline function getFile(id:Int):KontentumFile
	{
		var f:KontentumFile = null;
		if (filesIdIdentifier==null)
			return f;

		if (filesIdIdentifier.exists(id))
			f = filesIdIdentifier.get(id);

		return f;
	}

	static public overload extern inline function getFile(identifier:String):KontentumFile
	{
		var f:KontentumFile = null;
		if (filesByIdentifier==null)
			return f;

		if (filesByIdentifier.exists(identifier))
			f = filesByIdentifier.get(identifier);

		return f;
	}

	static public overload extern inline function getFileName(id:Int, absolutePath:Bool=false):String
	{
		var f:KontentumFile = null;
		if (filesIdIdentifier==null)
			return null;

		if (filesIdIdentifier.exists(id))
			f = filesIdIdentifier.get(id);

		if (absolutePath)
			return getFilePath(f);
		else
			return f.file;
	}

	static public overload extern inline function getFileName(identifier:String, absolutePath:Bool=false):String
	{
		var f:KontentumFile = null;
		if (filesByIdentifier==null)
			return null;

		if (filesByIdentifier.exists(identifier))
			f = filesByIdentifier.get(identifier);

		if (absolutePath)
			return getFilePath(f);
		else
			return f.file;
	}

	static public overload extern inline function getFilePath(file:KontentumFile):String
	{
		if (file==null)
			return null;

		if (fileURL!=null && fileURL!="")
			return fileURL+"/"+file.file;
		else 
			return file.file;
	}

	static public overload extern inline function getFilePath(id:Int):String
	{
		var f = getFile(id);
		return getFilePath(f);
	}

	static public overload extern inline function getFilePath(identifier:String):String
	{
		var f = getFile(identifier);
		return getFilePath(f);
	}

	static public function getTextIdentifiers():Array<String>
	{
		var r:Array<String> = [];
		if (textsByIdentifier!=null)
		{
			for (t in textsByIdentifier)
				r.push(t.identifier);
		}
		return r;
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
	static function startPing() 
	{
		//trace("Start Kontentum live update: "+pingTime);
		previousTimeStamp = DateUtils.getWDateInt();
		pingLoader = new Loader();
		pingLoader.disposeOnComplete = false;
		pingLoader.onComplete = onPingLoadedComplete;
		pingLoader.onError = onPingLoadedError;
		pingTimer = new haxe.Timer(pingTime);
		pingTimer.run = triggerPing;
	}
	
	static function triggerPing() 
	{
		pingLoader.onComplete = onPingLoadedComplete;
		pingLoader.loadJSON(pingURL);
	}
	
	static function onPingLoadedComplete(ul:Loader) 
	{
		// trace("pong:",ul.contentJSON);
		//if (ul!=null && ul.contentJSON!=null && ul.contentJSON.hasOwnProperty("last_modified"))
		//{
			//trace("ping-time: ",ul.contentJSON.last_modified);
			var newTime:Int = ul.contentJSON.last_modified;
			//trace("ping: ",newTime,previousTimeStamp);
			if (newTime > previousTimeStamp)
			{
				if (Reflect.hasField("select",ul.contentJSON))
					exhibit.select = ul.contentJSON.select;	

				trace("Kontentum updated!");
				previousTimeStamp = newTime;
				Loader.LoadJSON(fullURL, onRestLoadedPingComplete);
				// Loader.LoadJSON(fullURL, null, onRestLoadedPingComplete, onPingLoadedError);
			}
		//}
	}
	
	static function onPingLoadedError(ul:Loader) 
	{
		trace("Kontentium ping failed.");
		Timer.delay(triggerPing, pingTime);
	}
			
	static function onRestLoadedPingComplete(ul:Loader)
	{
		trace("Kontentum REST reloaded.");
		RESTJson = ul.contentJSON;
		content = RESTJson.content;
		languages = processLanguages();
		texts = processTexts();
		
		// Stage.bind.assets.setAssetContent();
		// Stage.bind.assets.forceRefresh();
		Timer.delay(triggerPing, pingTime);
	}
		
	/////////////////////////////////////////////////////////////////////////////////////
	
	static function kontentumReady() 
	{
		assetsLoaded = true;
		if (onComplete!=null)
			onComplete();			
	}	
	
	/////////////////////////////////////////////////////////////////////////////////////

/*	
	static function preloadAssets()
	{
		if (files!=null)
		{
			for (i in files) 
			{		
				// var f = UIX.getAsset(fid, "file");
				var file:KontentumFile = files[i];
				if (file.type=="image")
				{
					Loader.addToQueue(Kontentum.fileURL+file.file);
				}
			}
			if (Loader.loaderQueue!=null && Loader.loaderQueue.length>0)
			{
				Loader.onQueueItemStartedCallback = onPreloadItemStarted;				
				Loader.runQueue(onPreloadComplete,onPreloadError,onPreloadItemComplete,onPreloadItemProgress);
			}
			else 
				onPreloadComplete();
		}
		else 
			onPreloadError();
	}
	
	static function onPreloadItemStarted(l:Loader)
	{
		if (onPreloadFilesStarted!=null)
			onPreloadFilesStarted({current:Loader.loaderQueueIndex+1,total:Loader.loaderQueue.length});
	}
	
	
	static function onPreloadItemProgress(l:Loader)
	{
		if (onPreloadFilesProgress!=null)
			onPreloadFilesProgress({current:Loader.loaderQueueIndex+1,total:Loader.loaderQueue.length});
	}
	
	static function onPreloadItemComplete(l:Loader)
	{
		// trace(Loader.loaderQueueIndex+1+" / "+Loader.loaderQueue.length);
		if (onPreloadFilesItemComplete!=null)
			onPreloadFilesItemComplete({current:Loader.loaderQueueIndex+1,total:Loader.loaderQueue.length});
	}

	static function onPreloadComplete()
	{
		kontentumReady();
	}
	
	static function onPreloadError()
	{
		kontentumReady();
	}
	
	#if (kore_kha || cpp)
		
	static public function downloadAllFiles(fileDir:String="")
	{
		var filesInDir:stage.files.Files = new stage.files.Files(fileDir, true, true, false);
		deleteNonExistingFiles(filesInDir);
		
		if (RESTJsonStr!=null)
			filesInDir.saveTextFile("exhibit" + exhibitToken + ".json", RESTJsonStr, true);
		
		for (name in files) 
		{
			var cf:stage.files.File = filesInDir.getFile(files[name].file);
			if ( (cf!=null && DateUtils.getWDateInt(cf.modified) < Std.parseInt(files[name].modified)) || (cf==null) )
			{
				var dlFile:String = fileURL+files[name].file;
				if (dlFile!=null && dlFile!="null")
					Loader.addToQueue(dlFile);
			}
		}	
		
		Loader.onQueueItemStartedCallback = onQueueItemStarted;
		Loader.onQueueItemProgressCallback = onQueueItemProgress;
		Loader.onQueueItemCompleteCallback = onQueueItemCompleted;
		Loader.onQueueItemLoadErrorCallback = onQueueItemError;
		Loader.onQueueCompleteCallback = onQueueCompleted;
		fileDownloader = Loader.downloadQueue(localFileDir);
	}
		
	static function deleteNonExistingFiles(filesInDir:stage.files.Files)
	{
		var newFiles:Array<stage.files.File> = [];
		var markedForDeletion:Array<stage.files.File> = [];
		
		if (filesInDir != null)
		{
			for (j in 0...filesInDir.currentDirFiles.length) 
			{
				var df:String = filesInDir.currentDirFiles[j].fileName;
				var found:Bool = false;
				
				for (name in files) 
				{
					var fN:String = files[name].file;
					if (fN==df)
					{
						found = true;
						break;
					}
				}
				if (!found)
					markedForDeletion.push(filesInDir.currentDirFiles[j]);
			}
			
 			for (k in 0...markedForDeletion.length) 
			{
				var fnn:stage.files.File = markedForDeletion[k];
				if (fnn!=null && fnn.isValid)
				{
					var en:Int = fnn.fileName.indexOf("exhibit");
					var to:Int = fnn.fileName.indexOf(".json");
					if (en < 0 && to < 0)
					{
						fnn.delete();
					}
				}
			}
			filesInDir.readDir();
		}
	}

	static function onQueueItemStarted(ld:Loader)
	{
		trace("Downloading "+ld.fileName+" .......");
	}

	static function onQueueItemProgress(ld:Loader)
	{
		var numList:String = "["+(Loader.loaderQueueIndex+1)+"/"+Loader.loaderQueue.length+"] ";
		downloadFilesProgressString = numList+ld.fileName +" : "+StringUtils.floatToString(ld.bytesLoaded/1024,1)+" kB / "+StringUtils.floatToString(ld.bytesTotal/1024,1)+" kB [ "+StringUtils.floatToString(ld.loadingProgress*100,1)+"% ]";
		if (onDownloadFilesProgress!=null)
			onDownloadFilesProgress();
	}

	static function onQueueItemCompleted(ld:Loader)
	{
		if (onDownloadFilesItemComplete!=null)
			onDownloadFilesItemComplete();
	}

	static function onQueueItemError(ld:Loader)
	{
		trace("Failed to download: "+ld.source);
	}

	static function onQueueCompleted()
	{
		trace("All files downloaded!!");
		assetsFetched();
	}

	#end */
/*		
	function checkPreload()
	{
		if (preloadImages)
		{
			//var fd:String = UIXGuiScanner.localFilePath;
			downloadedFiles = new Files(localFileDir, true, false, false);
			//UIXLoader.LoadImage(	
			//UIXLoader.createQueue({onQueueComplete:allImagesPreloaded});
		//
			//for (var j:int = 0; j < downloadedFiles.currentDirFiles.length; j++) 
			//{
				//var fname:String = downloadedFiles.currentDirFiles[j].name.toLowerCase();;
				//if (fname.indexOf(".jpg")!=-1 || fname.indexOf(".png")!=-1 || fname.indexOf(".gif")!=-1 || fname.indexOf(".bmp")!=-1)
					//UIXLoader.addToQueue(downloadedFiles.currentDirFiles[j].nativePath, {useCache:true, sourceFiletype:UIXLoader.FILETYPE_IMAGE, metaData:{fileName:downloadedFiles.currentDirFiles[j].name, onQueueItemComplete:onFilePreLoaded}});
			//}
			//UIXLoader.runQueue();		
			allImagesPreloaded();
		}
		else
			noPreload();
	}
		
	function allFilesDownloaded()
	{
		//UIX.console.debug("loading complete");
		checkPreload();
	}
		
	function noPreload() 
	{
		assetsLoaded = true;
		UIX.assets.forceRefresh();
		if (onComplete!=null)
			onComplete();			
	}
*/	
	/////////////////////////////////////////////////////////////////////////////////////
	
	static function processVariables(vars:Dynamic):Object
	{
		var rObj:Object = {};
		if (vars!=null)
		{
			for (n in Reflect.fields(vars))
			{
				rObj[n]=Reflect.field(vars, n);			
			}
		}
		return rObj;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static function set_currentLanguage(value:KontentumLanguage):KontentumLanguage 
	{
		if (currentLanguage!=value)
		{
			currentLanguage = value;
			// Stage.bind.assets.forceRefresh();
			// Stage.events.dispatch(Kontentum.LANGUAGE_CHANGED, currentLanguage, Kontentum);
		}
		return currentLanguage;
	}
		
	/////////////////////////////////////////////////////////////////////////////////////
	
	static public function submitAction(identifier:String, metadata:String = '')
	{
		// Loader.LoadJSON(rest_ip +'/rest/submitAction/' + exhibitToken + '/' + StringTools.urlEncode(identifier) + '/' + StringTools.urlEncode(metadata), null, onActionResponse, onActionResponse);
		Loader.LoadJSON(rest_ip + '/rest/submitAction' + exhibitToken + '/' + identifier + '/' + metadata,{ formData:{ exhibit_token:exhibitToken, identifier:identifier, metadata:metadata },usePost:true, onComplete:onActionResponse, onError:onActionResponse});
	}

	static function onActionResponse(ul:Loader)
	{
		if (ul.contentJSON != null)
		{
			var json:Object = ul.contentJSON;
			
			if (json.hasOwnProperty('success'))
			{
				trace('submitAction: ' + json['success']);
			}
			else
			{
				trace('submitAction: error');
			}
		}
		else
		{
			trace('submitAction: error');
		}
	}

	/////////////////////////////////////////////////////////////////////////////////////

	// static public function getScoreboard(interval:String, rows:UInt = 10, metaFilter:String="", onResponse:(Loader)->Void=null, onFail:(Loader)->Void=null):Loader
	// {
	// 	/* Valid intervals:
	// 		'D' = Day
	// 		'W' = Week
	// 		'M' = Month
	// 		'Y' = Year
	// 		'A' = All-time high
	// 	*/
	// 	return Loader.LoadJSON(rest_ip +'/rest/getScoreboard/' + exhibitToken + '/' + interval + '/' + rows + '/' + metaFilter, null, onResponse, onFail );
	// }
/* 
	static public function submitScore(name:String, score:UInt, metadata:String = '', onResponse:(Loader)->Void, onFail:(Loader)->Void):Loader
	{
		return Loader.LoadJSON(rest_ip + '/rest/submitScore/' + exhibitToken + '/' + StringTools.urlEncode(name) + '/' + score + '/' + StringTools.urlEncode(metadata), null, onResponse, onFail);
	}

	static public function multipleScoresAdd(name:String, score:UInt, metadata:String = '')
	{
		multipleScoresArray.push(name + '|' + Std.string(score) + '|' + metadata);
	}

	static public function multipleScoresSubmit(onResponse:(Loader)->Void, onFail:(Loader)->Void):Loader
	{
		var scoreData:String = multipleScoresArray.join('--');
		var l = Loader.LoadJSON(rest_ip + '/rest/submitMultipleScores/' + exhibitToken + '/' + StringTools.urlEncode(scoreData), null, onResponse, onFail);
		multipleScoresArray = [];
		return l;
	}
 */	

	static public function submitClientInfo(info:String):Loader
	{
		var submitURL:String = '$rest_ip/$rest_clientInfo/$exhibitToken/$clientID/'+StringTools.urlEncode(info);
		trace(submitURL);
		return Loader.LoadJSON(submitURL);
	}

	/////////////////////////////////////////////////////////////////////////////////////	

	static public function setSelect(element_id:UInt, state:Int=-1, ?onResponse:(Loader)->Void):Loader
	{
		return Loader.Load(rest_ip + '/rest/setSelect/' + exhibitToken + '/' + element_id + '/' + state, {sourceFiletype:"json", onComplete:onResponse, onError:onResponse});
	}

/*  	static public function setContent(template_identifier:String, language_identifier:String="no", ?contentObject:Dynamic, ?element_id:UInt=0, ?apiKey:String):Loader
	{
		// var loader:URLLoader = new URLLoader();
		// var request:URLRequest = new URLRequest();
		// var variables:URLVariables = new URLVariables;

		// for (var i:String in contentObject) {
		// 	variables[i] = contentObject[i].toString();
		// }

		// var url = rest_ip + '/rest/setContent/' + ApiKey + '/' + template_identifier + '/' + slanguage_identifier + '/' + element_id;
		// request.method = URLRequestMethod.POST;
		// request.data = variables;

		var ak:String = Kontentum.apiKey;

		if (apiKey!=null)
			ak = apiKey;

		return Loader.SendPOSTvariables('$rest_ip/rest/setContent/$ak/$template_identifier/$language_identifier/$element_id',contentObject,
		{
			onComplete:(l:Loader)->trace(l.contentJSON), 
			onError:(l:Loader)->trace("rest error: "+l.source)
		});
	} */
 	
	////////////////////////////////////////////////////////////////////////////////////	

	static public function getVar(varName:String):Dynamic
	{
		// if (exhibit != null && exhibit.variables != null && exhibit.variables.hasOwnProperty(varName))
			// return exhibit.variables[varName];
		// else
			return null;
	}

	static public function filePath(localPath:String):String
	{
		return fileURL+localPath;
	}

	/////////////////////////////////////////////////////////////////////////////////////	

	//===================================================================================
	// Dispose 
	//-----------------------------------------------------------------------------------		
	
	public function dispose()
	{
		
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}
