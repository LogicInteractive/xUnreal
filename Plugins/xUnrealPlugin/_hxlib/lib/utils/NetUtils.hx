package lib.utils;

/**
 * ...
 * @author Tommy Svensson
 */
class NetUtils 
{
	public static function intToIP(int):String
	{
		var part1 = int & 255;
		var part2 = ((int >> 8) & 255);
		var part3 = ((int >> 16) & 255);
		var part4 = ((int >> 24) & 255);

		return part1 + "." + part2 + "." + part3 + "." + part4;
	}
}