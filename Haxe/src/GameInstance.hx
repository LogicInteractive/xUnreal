package;

import unreal.DynamicMulticastDelegate;
import unreal.GameInstance;

@:keep
class OCGameInst extends GameInstance
{
	/////////////////////////////////////////////////////////////////////////////////////

	var tester:DynamicMulticastDelegate<String->Void> = {};

	/////////////////////////////////////////////////////////////////////////////////////

    public function new()
	{
		super();
    }

	override public function Init()
	{
		trace("INIT");
		tester.add(s->trace('Init c : $s'));
	}

	override public function Shutdown()
	{
		trace("SHUTDOWN");
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

