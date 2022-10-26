package;

import unreal.GameModeBase;
import unreal.DynamicMulticastDelegate;

@:keep
class OCGameMode extends GameModeBase
{
	/////////////////////////////////////////////////////////////////////////////////////

	var gmDelegate:DynamicMulticastDelegate<Bool->Void> = {};

	/////////////////////////////////////////////////////////////////////////////////////

    public function new()
	{
		super();
    }

	override public function BeginPlay()
	{
		super.BeginPlay();
		trace("GameMode start");
		gmDelegate.add(b->trace('Init g : $b'));
	}

	override public function EndPlay()
	{
		trace("GameMode end");
		super.EndPlay();
	}

	override public function Tick(deltaSeconds:Float)
	{
		super.Tick(deltaSeconds);
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

