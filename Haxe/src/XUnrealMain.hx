package;

import unreal.Actor;
import unreal.UExposed.Bridge;

class XUnrealMain extends unreal.UExposed implements Bridge
{
	/////////////////////////////////////////////////////////////////////////////////////

	/////////////////////////////////////////////////////////////////////////////////////

	static function main()
	{
		// CompileTime.importPackage("xunreal");
		// CompileTime.importPackage("app");
	}

	public function new()
	{
		super();
		trace("xUnreal process started.");
	}	

	/////////////////////////////////////////////////////////////////////////////////////
}