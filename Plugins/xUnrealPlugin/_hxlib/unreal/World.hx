package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;

@:nogenerate
@:cppFileCode('
double _getTimeSeconds();
')
class World extends unreal.UExposed
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public function getTimeSeconds():Float
	{
		return untyped __global__._getTimeSeconds();
	}

	/////////////////////////////////////////////////////////////////////////////////////
}