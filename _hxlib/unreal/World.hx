package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;

@:cppFileCode('
double _getTimeSeconds();
')
class World extends unreal.UExposed
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public function getTimeSeconds():Float
	{
		return untyped __cpp__('_getTimeSeconds()');
	}

	/////////////////////////////////////////////////////////////////////////////////////
}