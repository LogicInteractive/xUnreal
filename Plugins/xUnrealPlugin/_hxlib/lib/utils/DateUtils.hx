package lib.utils;

/**
 * ...
 * @author Tommy S.
 */
class DateUtils
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	static var days_nb		: Array<String>		= ["søndag", "mandag", "tirsdag", "onsdag", "torsdag", "fredag", "lørdag"];
	static var days_en		: Array<String>		= ["sønday", "monday", "tuesday", "wednesday", "tursday", "friday", "saturday"];
	static var months_nb	: Array<String>		= ["januar", "februar", "mars", "april", "mai", "juni", "juli", "august", "september", "oktober", "november", "desember"];
	static var months_nb_s	: Array<String>		= ["jan.", "feb.", "mar.", "apr.", "mai", "jun.", "jul.", "aug.", "sept.", "okt.", "nov.", "des."];
	static var months_en	: Array<String>		= ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"];
	static var months_en_s	: Array<String>		= ["jan.", "feb.", "mar.", "apr.", "may", "jun.", "jul.", "aug.", "sept.", "oct.", "nov.", "dec."];

	/////////////////////////////////////////////////////////////////////////////////////
	
/*	public static function parseUTCDate( str : String ) : Date
	{
		var matches : Array = str.match(/^(\d{4})-?(\d{2})-?(\d{2})(?:[T ](\d{2}):?(\d{2}):?(\d{2})?(?:\.(\d{3,}))?(?:(Z)|([+\-])(\d{2})(?::?(\d{2}))?))/);

		var d : Date = new Date();
		//d.setTime(Date.parse(str));

		d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
		d.setUTCHours(int(matches[4]), int(matches[5]), int(matches[6]), 0);
		return d;
	}	*/	
	
	public static function getWeekDayName( date:Date, lang:String="nb"):String
	{
		var dayNr:Int = date.getDay();
		if (lang == "nb")
			return days_nb[dayNr]
		else if (lang == "en")
			return days_en[dayNr]
		else 
			return "";
	}
	
	public static function getMonthName( date:Date, short:Bool=false, lang:String="nb"):String
	{
		var monthNr:Int = date.getMonth();
		if (lang == "nb" && !short)
			return months_nb[monthNr]
		else if (lang == "nb" && short)
			return months_nb_s[monthNr]
		else if (lang == "en" && !short)
			return months_en[monthNr]
		else if (lang == "en" && short)
			return months_en_s[monthNr]
		else 
			return "";
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	static public function getFormattedDay(date:Date = null):String
	{
		if (date == null)
			date = Date.now();
			
		return StringUtils.enforceTwoDigitNumberToString(date.getDate()) + "/" + StringUtils.enforceTwoDigitNumberToString((date.getMonth() + 1));
	}
	
	static public function getFormattedTime(date:Date = null, includeSeconds:Bool=false):String
	{
		if (date == null)
			date = Date.now();
			
		var t = StringUtils.enforceTwoDigitNumberToString(date.getHours()) + ":" + StringUtils.enforceTwoDigitNumberToString(date.getMinutes());
		var t = StringUtils.enforceTwoDigitNumberToString(date.getHours()) + ":" + StringUtils.enforceTwoDigitNumberToString(date.getMinutes());
		if (includeSeconds)
			t += ":" + date.getSeconds();
			
		return t;
	}
	
	static public function getFormattedDate(date:Date = null,pathFriendly:Bool=false):String
	{
		if (pathFriendly)
			return getFormattedDay(date)+"_"+date.getFullYear()+"_"+getFormattedTime(date);
		else
			return getFormattedDay(date)+"/"+date.getFullYear()+" "+getFormattedTime(date);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function isOlderThan(isA:Date,olderThanB:Date):Bool
	{
		return isA.getTime()<olderThanB.getTime();
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
	public static function getWDateString(date:Date=null):String
	{
		var correctDate = date;
		if (correctDate == null)
			correctDate = Date.now();
			
		var ds:String = correctDate.getFullYear() + p2(correctDate.getMonth()+1) + p2(correctDate.getDate()) + p2(correctDate.getHours()) + p2(correctDate.getMinutes()) + p2(correctDate.getSeconds());
		return ds;
	}
	
	public static function getDayDateMonthString(date:Date=null, lang:String="nb", uppercaseFirst:Bool=true):String
	{
		var correctDate = date;
		if (correctDate == null)
			correctDate = Date.now();
			
		var ds:String = getWeekDayName(correctDate, lang) + " " + correctDate.getDate() + " " + getMonthName(correctDate, lang);
		if (uppercaseFirst)
			ds = StringUtils.toFirstCharUppercase(ds);
		return ds;
	}
	
	public static function getWDateInt(date:Date=null):Int
	{
		return Std.parseInt(getWDateString(date));
	}
	
	private static function p2(d:Int):String
	{
		if (d < 10)
			return "0" + Std.string(d);
		else
			return Std.string(d);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}
