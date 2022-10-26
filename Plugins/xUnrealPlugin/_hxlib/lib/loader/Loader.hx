package lib.loader;

import haxe.Exception;
import haxe.Json;
import haxe.Timer;
import haxe.io.Bytes;
import haxe.io.Path;
import lib.types.FileType;
import lib.utils.FileUtils;
import lib.utils.ObjUtils;
import lib.utils.TimeTrack;

/**
 * ...
 * @author Tommy Svensson
 */

class Loader
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline var LOCAL_FILE		: String 					= "urlloader_localFile";
	static public inline var WEB_URL		: String					= "urlloader_webaddress";

	public var source						: String;

	public var parent						: Dynamic;
	public var fileName						: String;
	public var saveFileName					: String;
	public var loadtime						: Float;
	public var type							: FileType;
	public var pathType						: String;
	public var destinationFolder			: String;
	public var pathIsAbsolute				: Bool						= false;
	public var saveFile						: Bool						= false;
	public var disposeOnComplete			: Bool						= false;
	public var preventFileCaching			: Bool						= false;
	public var autoParse					: Bool						= true;
	public var isDisposed					: Bool						= false;
	public var metaData						: Dynamic;
	
	public var bytesLoaded					: Int;
	public var bytesTotal					: Int;
	public var loadingProgress				: Float;
	public var async						: Bool						= true;

	var startTime							: Float;
	var endTime								: Float;
	var createImage							: Bool;

	public var method						: String		= "GET";
	public var contentTEXT					: String;
	public var contentXML					: Xml;
	public var contentJSON					: Dynamic;
	// public var contentTILE					: Tile;
	// public var contentIMAGE					: stage.graphics.Image;
	// public var contentHEAPSIMAGE			: hxd.res.Image;
	public var contentBYTES					: haxe.io.Bytes;
	public var contentRAW					: Any;
	public var contentIsBinary				: Bool						= false;
	public var contentForceBinary			: Bool						= false;
	var parsedFileType						: FileType					= FileType.BINARY;

	public var lastHTTPResponse				: com.akifox.asynchttp.HttpResponse;
	public var formData						: Dynamic;
	public var stringifyFormData			: Bool						= false;
	public var requestHeaders				: Map<String,String>;
	
	public var onComplete					: (Loader)->Void;
	public var onProgress					: (Loader)->Void;
	public var onError						: (Loader)->Void;

	public static var appFolder				: String					= "";

	/////////////////////////////////////////////////////////////////////////////////////
	
	public function new(?source:String,?onComplete:(Loader)->Void,?onError:(Loader)->Void,?properties:Dynamic)
	{
		setProps(properties);
		if (onComplete!=null)
			this.onComplete = onComplete;
		if (onError!=null)
			this.onError = onError;
		if (source!=null)
			this.source = source;

		if (this.source!=null)
			load(source);
	}	
	
	/////////////////////////////////////////////////////////////////////////////////////

	public function setProps(props:Null<Dynamic>) 
	{
		ObjUtils.setProperties(props,this);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function Load(source:String,?onComplete:(Loader)->Void,?properties:Dynamic,?type:FileType) 
	{
		if (type!=null)
			if (properties==null) properties = {type:type} else properties.type = type;

		return new Loader(source,onComplete,null,properties);
	}

	public function load(source:String):Loader
	{
		this.source = processPath(source);
		if (this.source != null)
		{
			contentRAW = null;
			if (pathType==Loader.WEB_URL #if js || true #end)
				loadFromURL();
			else
				loadFromFile();
		}
		return this;
    }

	public function loadSound(source:String):Loader
	{
		this.type = FileType.SOUND;
		load(source);
		return this;
	}

	public function loadImage(source:String):Loader
	{
		createImage = true;
		this.type = FileType.IMAGE;
		load(source);
		return this;
	}

	public function loadJSON(source:String):Loader
	{
		this.type = FileType.JSON;
		load(source);
		return this;
	}

	public function loadText(source:String):Loader
	{
		this.type = FileType.TEXT;
		load(source);
		return this;
	}

	public function loadXML(source:String):Loader
	{
		this.type = FileType.XML;
		load(source);
		return this;
	}

	static public function LoadSound(source:String,?onComplete:(Loader)->Void,?onError:(Loader)->Void,?properties:Dynamic)		return new Loader(null,onComplete,onError,properties).loadSound(source);
	static public function LoadImage(source:String,?onComplete:(Loader)->Void,?onError:(Loader)->Void,?properties:Dynamic)		return new Loader(null,onComplete,onError,properties).loadImage(source);
	static public function LoadJSON(source:String,?onComplete:(Loader)->Void,?onError:(Loader)->Void,?properties:Dynamic)		return new Loader(null,onComplete,onError,properties).loadJSON(source);
	static public function LoadText(source:String,?onComplete:(Loader)->Void,?onError:(Loader)->Void,?properties:Dynamic)		return new Loader(null,onComplete,onError,properties).loadText(source);
	static public function LoadXML(source:String,?onComplete:(Loader)->Void,?onError:(Loader)->Void,?properties:Dynamic)		return new Loader(null,onComplete,onError,properties).loadXML(source);

	/////////////////////////////////////////////////////////////////////////////////////

	function processPath(url:String):String 
	{
		if (url == null)
			return url;
			
		parsedFileType = FileUtils.getFileType(url);
		fileName = FileUtils.getFilenameFromFilePath(url);

		pathType = FileUtils.isURL(url) ? Loader.WEB_URL : Loader.LOCAL_FILE;
		if (!FileUtils.isURL(url))
		{
			#if linux
			url = url.split("\\").join("/");
			pathIsAbsolute = url.indexOf(":/")>-1;
			#else
			url = url.split("/").join("\\");
			pathIsAbsolute = url.indexOf(":\\")>-1;
			#end
			// if (!pathIsAbsolute)
				// url=Loader.appFolder+url;
			return url;
		}
		else
		{
			if (url.indexOf("http://") !=-1)
			{
				var tu = url.split("http://").join("");
				var mx = tu.split("/");
				
				var nu = "http://" + mx.shift();
				var cstr = mx.join("/");
				nu += "/" + cstr;
				url = nu.split("%2F").join("/");
				return url;
			}
			else if (url.indexOf("https://") !=-1)
			{
				var tu = url.split("https://").join("");
				var mx = tu.split("/");
				var nu = "https://" + mx.shift();
				var cstr = mx.join("/");
				nu += "/"+cstr;
				url = nu.split("%2F").join("/");
				return url;
			}
		}		
		return url;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function loadFromFile()
	{
		if (FileUtils.exists(source))
		{
			TimeTrack.start("load");
			var nc:String = "";
			var b:Bytes = FileUtils.loadBinaryFile(source);
			if (b!=null)
				onBytesLoaded(b);
			else
				onFileLoadError(null);
		}
	}
	function loadFromURL()
	{
		startTime = Timer.stamp();
		var httpRequest = new com.akifox.asynchttp.HttpRequest(
		{
			url 				: source, 
			method 				: method, 
			callback			: onHttpResponseFile,
			callbackProgress	: onLoadHttpRequestProgress, 
			callbackError		: onHttpResponseError, 
			async 				: this.async, 
			http11 				: true
		});
		httpRequest.timeout = 30;
		httpRequest.send();				
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function onHttpResponseFile(response:com.akifox.asynchttp.HttpResponse)
	{
		lastHTTPResponse = response;
		if (response.isOK)
		{
			if (response.content != null)
			{
				if (type == null)
					type = parsedFileType;
		
				contentIsBinary = determineIsBinary(type);		
				contentRAW = response.contentRaw;
				parseLoadedData();		
			}
		}
	}  	

	function onHttpResponseError(response:com.akifox.asynchttp.HttpResponse)
	{
		trace(response.error);
	}

	public function onBytesLoaded(bytes:Bytes)
	{
		this.contentRAW = bytes;

		if (type == null)
			type = parsedFileType;
		contentIsBinary = determineIsBinary(type);		
		parseLoadedData();		
	}

	@:dox(hide)
	public function determineIsBinary(contentKind:FileType):Bool
	{
		if (contentKind == FileType.BINARY || contentKind == FileType.IMAGE || contentKind == FileType.VIDEO || contentKind == FileType.SOUND) return true;
			return false;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	public function onFileLoadError(e) 
	{
		TimeTrack.stop("load");
		if (onError != null)
			onError(this);
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function parseLoadedData()
	{
		loadtime = Timer.stamp();
		if (contentIsBinary)
			contentBYTES = (contentRAW:Bytes);
			
		if (autoParse)
		{
			if (type==FileType.TEXT)
			{
				try
				{
					contentTEXT = Std.string(contentRAW);
					finishedLoading();
				} 
				catch (e:Exception)
					trace(e.stack);
			}
			else if (type==FileType.JSON)
			{
				try
				{
					contentTEXT = Std.string(contentRAW);
					contentJSON = haxe.Json.parse(contentTEXT);
				} 
				catch (e:Exception)
				{
					trace("Error decoding JSON!");
					trace(contentRAW);
					trace(e.stack);
				}
				finishedLoading();
			}
			else if (type==FileType.XML)
			{
				try
				{
					contentTEXT = Std.string(contentRAW);
					contentXML= Xml.parse(contentTEXT);
				}
				catch (e:Exception)
				{
					// DebugInspector.i.warning("content error");
					trace("Error validating XML!");
					trace(contentRAW);
					trace(e.stack);
				}
				finishedLoading();
			}
			// else if (type==FileType.IMAGE)
			// {
			// 	if (createImage)
			// 	{
			// 		this.contentHEAPSIMAGE = hxdimageFromBytes(contentRAW);
			// 		if (this.contentHEAPSIMAGE!=null)
			// 		{
			// 			this.contentIMAGE = stage.graphics.Image.from(this.contentHEAPSIMAGE);
			// 			this.contentIMAGE.path = source;
			// 			this.contentTILE = this.contentIMAGE.tile;
			// 		}
			// 	}
			// 	finishedLoading();
			// }
			else
			{
				finishedLoading();
			}		
		}
		else
			finishedLoading();
	}

	function onLoadHttpRequestProgress(bytesLoaded:Int,bytesTotal:Int)
	{
		this.bytesLoaded = bytesLoaded;
		this.bytesTotal = bytesTotal;
		
		if (this.bytesTotal>0)
			this.loadingProgress = this.bytesLoaded/this.bytesTotal;
		else
			this.loadingProgress = 0;

		if (onProgress!=null)
			onProgress(this);
	}

	function finishedLoading()
	{
		if (contentIsBinary)
		{
			bytesLoaded = contentBYTES.length;
			bytesTotal = contentBYTES.length;
		}

		if (saveFile && destinationFolder!=null)
		{
			var finalFileName = saveFileName!=null?saveFileName:fileName;
			if (!writeFileData(finalFileName))
				trace("Failed to save:"+finalFileName);
		}

		if (lastHTTPResponse!=null)
			lastHTTPResponse = null;	
		
		TimeTrack.stop("load");
		if (onComplete != null)
			onComplete(this);	
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function writeFileData(?savefilename:String):Bool
	{
		var success:Bool = false;
		
		if (contentRAW==null)
			return false;

		if (savefilename==null)
			savefilename = fileName;
			
		var saveFile:String = destinationFolder + "\\" + savefilename;
		if (saveFile==null)
			return false;
		else 
			saveFile = saveFile.split("/").join("\\");

		try
		{
			if (!FileUtils.exists(destinationFolder))
				FileUtils.createDirectory(destinationFolder);
				
			FileUtils.saveBinaryFile(saveFile, contentRAW);
			success = true;
		}
		catch (e:Exception)
		{
			success = false;
			trace(e.stack);
		}
		return success;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	function getDomain(file:String):String
	{
		if (file == null)
			return null;
			
		file = file.split("https://").join("").split("http://").join("");
			
		if (file.indexOf("/") !=-1)
		{
			var fa = file.split("/");
			if (fa.length > 0)
				return fa[0];
		}
		
		return file;
	}
	
	function getDomainPath(file:String):String
	{
		if (file == null)
			return null;
		
		file = file.split("https://").join("").split("http://").join("");
			
		if (file.indexOf("/") !=-1)
		{
			var fa = file.split("/");
			if (fa.length > 1)
			{
				fa.shift();
				return fa.join("/");
			}
			else
				return "";
		}
		return "";
	}
	
	function stripHttp(file:String):String
	{
		if (file == null)
			return null;
			
		return file.split("https://").join("").split("https//").join("").split("http//").join("").split("http://").join("");
	}
	
	function isSecure(file:String):Bool
	{
		var isSec:Bool = false;
		if (file != null)
		{
			if (file.indexOf("http://") !=-1)
				isSec = false;
			else if (file.indexOf("http//") !=-1)
				isSec = false;
			else if (file.indexOf("https//") !=-1)
				isSec = true;
			else if (file.indexOf("https://") !=-1)
				isSec = true;
		}
		return isSec;
	}
	

	/////////////////////////////////////////////////////////////////////////////////////

	public function getContentBytes(dispose:Bool=true)
	{
		var b = contentBYTES;
		if (dispose)
			this.dispose();
		return b;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	public function unload()
	{
		if (contentTEXT!=null)
			contentTEXT = null;
		if (contentXML!=null)
			contentXML = null;
		if (contentJSON!=null)
			contentJSON = null;
		if (contentBYTES!=null)
		{
			contentBYTES = null;
		}
		if (contentRAW!=null)
		{
			contentRAW = null;
		}
		// if (contentIMAGE!=null)
		// {
		// 	contentIMAGE.dispose(true);
		// 	contentIMAGE=null;
		// }

	}
	
	public function dispose(unload:Bool=false)
	{
		if (unload)
			this.unload();

		if (source!=null)
			source = null;
		if (parent!=null)
			parent = null;
		if (fileName!=null)
			fileName = null;
		if (saveFileName!=null)
			saveFileName = null;
		if (type!=null)
			type = null;
		if (pathType!=null)
			pathType = null;
		if (destinationFolder!=null)
			destinationFolder = null;
		if (metaData!=null)
			metaData = null;
		if (method!=null)
			method = null;
		if (parsedFileType!=null)
			parsedFileType = null;
		if (formData!=null)
			formData = null;
		if (requestHeaders!=null)
			requestHeaders = null;
		if (onComplete!=null)
			onComplete = null;
		if (onProgress!=null)
			onProgress = null;
		if (onError!=null)
			onError = null;

		if (lastHTTPResponse!=null)
			lastHTTPResponse=null;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
