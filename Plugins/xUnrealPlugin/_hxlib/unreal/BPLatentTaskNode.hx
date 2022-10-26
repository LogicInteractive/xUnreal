package unreal;

import unreal.UExposed.Bridge;
import unreal.UExposed.UClass;

@:nogenerate
@:cppFileCode('
void _callLatentTaskNode(void* p, int task);
')
class BPLatentTaskNode extends UObjectBase implements UClass implements Bridge 
{
	/////////////////////////////////////////////////////////////////////////////////////

	var owner		: cpp.Star<cpp.Void>;
	
	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	public function setOwner(owner:cpp.Star<cpp.Void>)
	{
		this.owner = owner;
	}

	public function new()
	{
		super();
	}

	public function taskComplete()
	{
		untyped __global__._callLatentTaskNode(owner,0);
	}

	public function taskFailed()
	{
		untyped __global__._callLatentTaskNode(owner,1);
	}

	public function dispose()
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
