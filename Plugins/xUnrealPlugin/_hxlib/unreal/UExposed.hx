package unreal;

@:nogenerate
class UExposed
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

@:autoBuild(XUnreal.buildTemplates("U"))
interface UClass{}

@:autoBuild(XUnreal.buildTemplates("A"))
interface AClass{}

@:nogenerate
@:autoBuild(HaxeCBridge.expose())
interface Bridge{}