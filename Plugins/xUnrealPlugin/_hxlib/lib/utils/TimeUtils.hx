package lib.utils;

class TimeUtils 
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	public static function getFormatedTimeStamp(?date:Date):String 
	{
		if (date==null)
			date = Date.now();

		var eTime:String = "";
		var eHours:Float = date.getHours();
		var eMinut:Float = date.getMinutes();
		var eSecon:Float = date.getSeconds();
		eHours < 10 ? eTime+="0"+Std.int(eHours) : eTime+=Std.int(eHours);
		eTime+= ":";
		eMinut < 10 ? eTime+="0"+Std.int(eMinut) : eTime+=Std.int(eMinut);
		eTime+= ":";
		eSecon < 10 ? eTime+= "0" + Std.int(eSecon) : eTime+= Std.int(eSecon);
		
		return eTime;
	}
		
	public static function getFormatedDayTimeStamp(?date:Date,includeYear:Bool=false):String 
	{
		if (date==null)
			date = Date.now();

		var eTime:String = "";
		var eHours:Float = date.getHours();
		var eMinut:Float = date.getMinutes();
		eHours < 10 ? eTime+="0"+Std.int(eHours) : eTime+=Std.int(eHours);
		eTime+= ":";
		eMinut < 10 ? eTime+="0"+Std.int(eMinut) : eTime+=Std.int(eMinut);
		eTime+= " ";
		eTime+=Std.string(date.getDate());
		eTime+="/";
		eTime+=Std.string(date.getMonth()+1);
		eTime+="/";
		if (includeYear)
			eTime+=Std.string(date.getFullYear());
		
		return eTime;
	}
		
	/////////////////////////////////////////////////////////////////////////////////////
	
	static public function convertToMMSS(seconds:Float, contractString:Bool=false, delimiter:String=":"):String
	{
		var s:Int = Math.floor(seconds % 60);
		var m:Int = Math.floor((seconds % 3600 ) / 60);
		
		var minuteStr:String = doubleDigitFormat(m) + delimiter;
		var secondsStr:String = doubleDigitFormat(s);
		 
		if (contractString)
		{
			if (minuteStr == "00"+delimiter)
				minuteStr == "";
		}
		return minuteStr + secondsStr;
	}
	 
	
	static public function convertToHHMMSS(seconds:Float, contractString:Bool=false, delimiter:String=":"):String
	{
		var s:Int = Math.floor(seconds % 60);
		var m:Int = Math.floor((seconds % 3600 ) / 60);
		var h:Int = Math.floor(seconds / (60 * 60));
		 
		var hourStr:String = (h == 0) ? "" : doubleDigitFormat(h) + delimiter;
		var minuteStr:String = doubleDigitFormat(m) + delimiter;
		var secondsStr:String = doubleDigitFormat(s);
		 
		if (contractString)
		{
			if (hourStr == "00"+delimiter)
				hourStr == "";
			if (minuteStr == "00"+delimiter)
				minuteStr == "";
		}
		return hourStr + minuteStr + secondsStr;
	}
	 
	
	static public function convertToHHMM(seconds:Float, contractString:Bool=false, delimiter:String=":"):String
	{
		var m:Int = Math.floor((seconds % 3600 ) / 60);
		var h:Int = Math.floor(seconds / (60 * 60));
		 
		var hourStr:String = (h == 0) ? "" : doubleDigitFormat(h) + delimiter;
		var minuteStr:String = doubleDigitFormat(m) + delimiter;
		 
		if (contractString)
		{
			if (hourStr == "00"+delimiter)
				hourStr == "";
			if (minuteStr == "00"+delimiter)
				minuteStr == "";
		}
		return hourStr + minuteStr;
	}
	 
	
	static public function convertToHM(seconds:Float, contractString:Bool=false, delimiter:String=":"):String
	{
		var m:Int = Math.floor((seconds % 3600 ) / 60);
		var h:Int = Math.floor(seconds / (60 * 60));
		 
		var hourStr:String = (h == 0) ? "" : Std.string(h) + delimiter;
		var minuteStr:String = Std.string(m);
		 
		if (contractString)
		{
			if (hourStr == "0"+delimiter)
				hourStr == "";
			if (minuteStr == "0"+delimiter)
				minuteStr == "";
		}
		return hourStr + minuteStr;
	}
	 
	static private function doubleDigitFormat(num:Int):String
	{
		if (num < 10) 
		{
			return "0" + num;
		}
		return Std.string(num);
	}
		
	/////////////////////////////////////////////////////////////////////////////////////

	//public static function timeout(closure:Void->Void, time)
	//{
		//var hxTim:Timer = Timer.delay
	//}
/*		
		public static function getFormatedDateAndTimeStamp():String 
		{
			var date:Date = new Date();
			var eTime:String = "";
			var eDay:String = weekdays[date.getDay()];
			var eDate:Number = date.getDate();
			var eMonth:Number = date.getMonth()+1;
			var eYear:Number = date.getFullYear();
			var eHours:Number = date.getHours();
			var eMinut:Number = date.getMinutes();
			var eSecon:Number = date.getSeconds();
			eTime += eDay + " ";
			eDate < 10 ? eTime+="0"+eDate.toFixed() + "/" : eTime+=eDate.toFixed() + "/";
			eMonth < 10 ? eTime+="0"+eMonth.toFixed() : eTime+=eMonth.toFixed();
			eTime += "/" + eYear.toString() + " ";
			eHours < 10 ? eTime+="0"+eHours.toFixed() : eTime+=eHours.toFixed();
			eTime+= ":";
			eMinut < 10 ? eTime+="0"+eMinut.toFixed() : eTime+=eMinut.toFixed();
			eTime+= ":";
			eSecon < 10 ? eTime+="0"+eSecon.toFixed() : eTime+=eSecon.toFixed();
			return eTime;
		}
		
		public static function getFormatedDate():String 
		{
			var date:Date = new Date();
			var eTime:String = "";
			var eDay:String = weekdays[date.getDay()];
			var eDate:Number = date.getDate();
			var eMonth:Number = date.getMonth()+1;
			var eYear:Number = date.getFullYear();
			var eHours:Number = date.getHours();
			var eMinut:Number = date.getMinutes();
			var eSecon:Number = date.getSeconds();
			eTime += eDay + " ";
			eDate < 10 ? eTime+="0"+eDate.toFixed() + "/" : eTime+=eDate.toFixed() + "/";
			eMonth < 10 ? eTime+="0"+eMonth.toFixed() : eTime+=eMonth.toFixed();
			eTime += "/" + eYear.toString() + " ";
			return eTime;
		}
		
		static public function get stopWatch():StopWatch 
		{
			if (!_stopWatch)
				_stopWatch = new StopWatch;
				
			return _stopWatch;
		}
*/		
		/////////////////////////////////////////////////////////////////////////////////////
	//}
}
	