package lib.utils;

import haxe.io.Bytes;
import lib.loader.Loader;
import lib.types.FileType;
import sys.FileSystem;
// import lib.files.Files.FileType;

/**
 * ...
 * @author Tommy Svensson
 */
class FileUtils 
{
	static public var slash						: String			= "/";

	static public function isURL(path:String):Bool 
	{
		if (path == null)
			return false;
			
		if (path.indexOf("://") ==-1)
			return false;
		else if (path.indexOf("http://") !=-1)
			return true;
		else if (path.indexOf("https://") !=-1)
			return true;

		return false;
	}

	static public function setWorkingDirToProgram()
	{
		#if cpp
		var pPath:String = Sys.programPath();
		if (pPath!=null)
			Sys.setCwd(FileUtils.getDirFromFilePath(pPath));
		#end
	}

	static public function getFileType(filename:String):FileType
	{
		if (filename==null)
		filename = filename.toLowerCase();
		
		if (fio(filename, "jpg") || fio(filename, "png") || fio(filename, "gif") || fio(filename, "jpeg"))
			return FileType.IMAGE;
		else if (fio(filename, "txt") || fio(filename, "text") || fio(filename, "nfo"))
			return FileType.TEXT;
		else if (fio(filename, "mp4") || fio(filename, "flv") || fio(filename, "f4v") || fio(filename, "mov") || fio(filename, "avi") || fio(filename, "mpg") || fio(filename, "mkv") || fio(filename, "mpeg") || fio(filename, "wmv"))
			return FileType.VIDEO;
		else if (fio(filename, "mp3") || fio(filename, "wav"))
			return FileType.SOUND;
		else if (fio(filename, "swf") || fio(filename, "swc"))
			return FileType.TEXT;
		else if (fio(filename, "zf3d") || fio(filename, "f3d") || fio(filename, "obj") || fio(filename, "3ds") || fio(filename, "dae"))
			return FileType.TEXT;
		else if (fio(filename, "xml"))
			return FileType.XML;
		else
			return FileType.BINARY;
	}
	
	public static function getDirFromFilePath(path:String):String 
	{
		path = processPath(path);
		return path.substr(0,path.lastIndexOf(slash));
	}
	
	public static function getFilenameFromFilePath(path:String):String 
	{
		path = processPath(path);
		return path.substring(path.lastIndexOf(slash)+slash.length,path.length);
	}

	public static function stripFileExtension(filename:String):String
	{
		var ret:String = filename;
		if (filename!=null && (filename.indexOf(".") != -1))
		{
			ret = filename.substring(0, filename.lastIndexOf("."));
		}
		return ret;
	}
		
	public static function getFileExtension(filename:String):String
	{
		var ret:String = filename;
		if (filename!=null && (filename.indexOf(".") != -1))
		{
			ret = filename.substring(filename.lastIndexOf("."), filename.length);
		}
		return ret.split(".").join("");
	}

	static inline function processPath(fileNameOrDirectory:String):String
	{
		if (fileNameOrDirectory==null)
			return null;	

        return fileNameOrDirectory.split("\\").join("/");

		//if (fileNameOrDirectory!=null)
			//fileNameOrDirectory = fileNameOrDirectory.split("//").join(Files.slash).split("/").join(Files.slash).split("\\").join(slash).split("\r").join("").split("\n").join("");
			//
		//return FPaths.ConvertRelativePathToFull(FPaths.GameDir().toString() + fileNameOrDirectory).toString();
	}	

	static inline function fio(name:String,key:String):Bool
	{
		if (name.indexOf("."+key) == -1)
			return false;
		else
			return true;
	}

	public static function loadTextFile(fileName:String):String 
	{
		try
		{
			return sys.io.File.getContent(fileName);
		}
		catch(e:haxe.Exception)
		{
			trace(e.stack);
		}
		return null;
	}

	public static function loadBinaryFile(fileName:String, ?folder:String, ?check:Bool=false, ?findLocalPath:Bool=true):haxe.io.Bytes 
	{
		if (folder==null)
		{
			if (findLocalPath)
				folder = appFolder();
		}
		if (folder!="")
		{
			folder+="/";
		}

		var fFile:String = folder + "/" + fileName;	
		trace('ll $fFile');
		if (check)
			if (!sys.FileSystem.exists(fFile))
				return null;

		return sys.io.File.getBytes(fFile);
	}

	public static function exists(?fileName:String="", ?folder:String, ?findLocalPath:Bool=true):Bool 
	{
		if (folder==null)
		{
			if (findLocalPath)
				folder = appFolder();
		}
		if (folder!="")
		{
			folder+="/";
		}

		var fFile:String = folder + "/" + fileName;		
		trace('check $fFile');
		return sys.FileSystem.exists(fFile);
	}

	public static function saveTextFile(fileName:String, text:String="", destinationFolder:String, overwrite:Bool=true, append:Bool=false, ?findLocalPath:Bool=true):Bool 
	{
		var success:Bool = false;
		
		if (text==null)
			text = "";
			
		if (destinationFolder==null)
		{
			destinationFolder="";
			if (findLocalPath)
				destinationFolder = appFolder();
		}
		if (destinationFolder!="")
		{
			destinationFolder+="/";
			try 
			{
				if (!sys.FileSystem.exists(destinationFolder))
					sys.FileSystem.createDirectory(destinationFolder);
			}
			catch(e:haxe.Exception)
			{
				trace('ERROR: Unable to create directory $destinationFolder');
				trace(e.stack);
			}
		}

		var saveFile:String = destinationFolder + "/" + fileName;
			
		if (!append)
		{
			// if (!overwrite && sys.FileSystem.exists(saveFile))
				// saveFile+="_2";

			try
			{
				sys.io.File.saveContent(saveFile, text);
				success = true;
			}
			catch (e:haxe.Exception)
			{
				success = false;
				trace(e.stack);
			}
		}
		else if (append)
		{
			try
			{
				var fileOutput = sys.io.File.append(saveFile, false);
				fileOutput.writeString(text);
				fileOutput.close();
				success = true;
			}
			catch (e:haxe.Exception)
			{
				success = false;
				trace(e.stack);
			}
		}
		return success;
	}
		
	public static function saveBinaryFile(fileName:String, bytes:Bytes, ?destinationFolder:String, ?overwrite:Bool=true, ?append:Bool=false, ?createDirIfNeeded:Bool=true, ?findLocalPath:Bool=true):Bool 
	{
		var success:Bool = false;
		
		if (bytes==null)
			return false;
			
		if (destinationFolder==null)
		{
			destinationFolder="";
			if (findLocalPath)
			{
				#if sys
				destinationFolder = appFolder();
				#end
			}
		}
		

		var saveFile:String = destinationFolder + "/" + fileName;
			
		var cdir:String = FileUtils.getDirFromFilePath(saveFile);
		if (createDirIfNeeded && cdir!=null)
		{
			try 
			{
				if (!sys.FileSystem.exists(cdir))
					sys.FileSystem.createDirectory(cdir);
			}
			catch (e:haxe.Exception)
			{
				success = false;
				trace('ERROR: Unable to create directory $cdir');
				trace(e.stack);
			}
		}

		if (destinationFolder!="")
		{
			destinationFolder+="/";
			try 
			{
				if (!sys.FileSystem.exists(destinationFolder))
					sys.FileSystem.createDirectory(destinationFolder);
			}
			catch(e:haxe.Exception)
			{
				trace('ERROR: Unable to create directory $cdir');
				trace(e.stack);
			}
		}

		var fileExists:Bool = false;
		try
		{
			fileExists = sys.FileSystem.exists(saveFile);
		}
		catch (e:haxe.Exception)
		{
			success = false;
			trace(e.stack);
		}

		if (fileExists && append)
		{
			try
			{
				var fileOutput = sys.io.File.append(saveFile, true);
				fileOutput.write(bytes);
				fileOutput.close();
				success = true;
			}
			catch (e:haxe.Exception)
			{
				success = false;
				trace(e.stack);
			}
		}
		else if (!fileExists || (fileExists && overwrite))
		{
			try
			{
				sys.io.File.saveBytes(saveFile, bytes);
				success = true;
			}
			catch (e:haxe.Exception)
			{
				success = false;
				trace(e.stack);
			}
		}
		return success;
	}
		

	static public function readDir(path:String):Array<String>
	{
		if (FileSystem.isDirectory(path))
			return sys.FileSystem.readDirectory(path);
		else 
			return [];
	}

	static inline function appFolder():String
	{
		// var p = Sys.programPath();
		// return p.substring(0,p.lastIndexOf("\\"))+"\\";	
		return Loader.appFolder;	
	}

	public static function createDirectory(folder:String):Bool
	{
		try 
		{
			if (!sys.FileSystem.exists(folder))
				sys.FileSystem.createDirectory(folder);

			return true;
		}
		catch (e:haxe.Exception)
		{
			return false;
		}
	}

}