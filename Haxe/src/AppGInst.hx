package;

import unreal.GameInstance;

@:keep
class AppGInst extends GameInstance
{
	/////////////////////////////////////////////////////////////////////////////////////

    public function new()
	{
		super();
    }

	override public function Init()
	{
		trace("INIT");
	}

	override public function Shutdown()
	{
		trace("SHUTDOWN");
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

