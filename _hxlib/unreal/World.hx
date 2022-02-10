package unreal;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;

class World extends unreal.UExposed
{
	/////////////////////////////////////////////////////////////////////////////////////

	static var getTimeSecondsCB				: cpp.Callable<Void->Float>;

	/////////////////////////////////////////////////////////////////////////////////////

	static public function init(getTimeSecondsCB:cpp.Callable<Void->Float>)
	{
		World.getTimeSecondsCB = getTimeSecondsCB;
	}

	static public function getTimeSeconds():Float
	{
		if (getTimeSecondsCB!=null)
			return getTimeSecondsCB();
		else
			return 0;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}