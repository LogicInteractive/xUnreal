package;

import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

class UnrealBuild
{
	public static function main()
	{
		// var env:Map<String, String> = Sys.environment();
		// for (e in env.keys())
			// trace(e,env.get(e));

		var projectName="xUnreal5";
		var projectFile = "";
		var localFolder = Sys.getCwd();
		localFolder = localFolder.split("Plugins\\xUnrealPlugin/").join("");
		// trace(localFolder);
		for (f in FileSystem.readDirectory(localFolder))
			if (f.indexOf(".uproject")!=-1)
			{
				projectFile = f;
				break;
			}

		if (projectFile!="")
			projectName=projectFile.split(".uproject").join("");

		var p = new Process("powershell -command \"& { (Get-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\\SOFTWARE\\EpicGames\\Unreal Engine\\5.0' -Name 'InstalledDirectory' ).'InstalledDirectory' }");
		var enginePath:String = Std.string(p.stdout.readAll());
		enginePath = enginePath.split("\n").join("").split("\r").join("");
		p.close();

		var packageDir='C:\\UE5_Packaging\\$projectName';
		var editorBuildConfig = "Editor";
		var editorBuildTarget = "Development";
		var editorBuildPlatform = "Win64";
		var projectFile = localFolder+'\\$projectName.uproject';
		var script = '"$enginePath\\Engine\\Build\\BatchFiles\\Build.bat"';

		var cmd:String = '$script $projectName$editorBuildConfig $editorBuildPlatform $editorBuildTarget $projectFile -waitmutex';

		projectFile=projectFile.split("/").join("\\");
		Sys.command(cmd);
		// %PROJECT_NAME%%EDITOR_BUILD_CONFIG% %EDITOR_BUILD_PLATFORM% %EDITOR_BUILD_TARGET% %PROJECT_FILE% -waitmutex
   }
}