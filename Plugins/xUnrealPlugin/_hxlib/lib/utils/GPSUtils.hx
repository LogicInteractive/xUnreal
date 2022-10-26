package lib.utils;

/**
 * ...
 * @author Tommy S
 */

typedef GPSCoord = 
{
	var latitude	: Float;
	var longitude	: Float;
}

class GPSUtils
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	public static function processGPSCoord(input:String):GPSCoord
	{
		if (input == null)
			return null;
			
		if (input.indexOf('"') !=-1)
			return DMSStringToDecimalCoord(input);
		else
			return DDStringToDecimalCoord(input);
	}
	
	public static function DDStringToDecimalCoord(input:String):GPSCoord
	{
		input = input.split(" ").join("");
		var parts:Array<String> = input.split("°N").join(" ").split("°E").join(" ").split(" ");
		return {latitude:Std.parseFloat(parts[0]), Std.parseFloat(longitude:[1])};
	}
	
	public static function DMSStringToDecimalCoord(input:String):GPSCoord
	{
		var reg = ~/[^\d\w\.]+/;
		var parts = reg.split(input);
		var lat = convertDMSToDD(parts[0], parts[1], parts[2], parts[3]);
		var lng = convertDMSToDD(parts[4], parts[5], parts[6], parts[7]);
		
		return {latitude:lat, longitude:lng};
	}

	private static function convertDMSToDD(degrees:String, minutes:String, seconds:String, direction:String)
	{
		var dd = Std.parseFloat(degrees) + Std.parseFloat(minutes)/60 + Std.parseFloat(seconds)/(60*60);

		if (direction == "S" || direction == "W" || direction == "E" || direction == "Ø")
		{
			dd = dd * -1;
		} // Don't do anything for N or E
		
		return dd;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}