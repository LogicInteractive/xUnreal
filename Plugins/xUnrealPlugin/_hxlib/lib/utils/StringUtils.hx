package lib.utils;

/**
 * ...
 * @author 
 */

using StringTools;

class StringUtils
{
	/////////////////////////////////////////////////////////////////////////////////////
	
/*		public static function searchReplaceBrackets(inputStr:String, searchTerms:Object, outputTarget:*=null):String
	{
		var regExp:RegExp=/[{|}]/g;
		var out:String = inputStr;
		var matches:Array = inputStr.match(/\{\w+\}/g);

		for(var i:int = 0; i < matches.length; i++)
		{
			var nMatch:String = matches[i].replace(regExp, "");	
			for (var name:String in searchTerms) 
			{
				if (nMatch == name)
					out = out.replace("{"+nMatch+"}", searchTerms[name]);
			}
		}
		if (outputTarget)
			outputTarget = out;
			
		return out;
	}
	
	public static function searchReplaceDoubleBrackets(inputStr:String, searchTerms:Object, outputTarget:*=null):String
	{
		var regExp:RegExp=/[{{|}}]/g;
		var out:String = inputStr;
		var matches:Array = inputStr.match(/\{{\w+\}}/g);

		for(var i:int = 0; i < matches.length; i++)
		{
			var nMatch:String = matches[i].replace(regExp, "");	
			for (var name:String in searchTerms) 
			{
				if (nMatch == name)
					out = out.replace("{{"+nMatch+"}}", searchTerms[name]);
			}
		}
		if (outputTarget)
			outputTarget = out;
			
		return out;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function dottedPriceString(value:Number):String 
	{
		var sNR:String = value.toString();
		var fAr:Array=sNR.split(".");
		var reg:RegExp=/\d{1,3}(?=(\d{3})+(?!\d))/;

		while (reg.test(fAr[0]))
		{
			fAr[0]=fAr[0].replace(reg,"$&.");
		}
		return fAr.join(".");
	}
*/	
	public static function replace(textIn:String,find:String,replaceBy:String):String
	{
		return StringTools.replace(textIn,find,replaceBy);
	}

	public static function stringToType(input:String):Any
	{
		if (StringUtils.isStringInt(input))
			return Std.parseInt(input);
		else if (StringUtils.isStringFloat(input))
			return Std.parseFloat(input);
		else if (StringUtils.isStringBool(input))
			return Convert.toBool(input);
		else
			return input;
	}

	static public function randomFromArray(inputStrings:Array<String>):String 
	{
		if (inputStrings == null || inputStrings.length==0)
			return null;
			
		var r:Int = MathUtils.getRandomIntInRange(0,inputStrings.length-1);
		return inputStrings[r];
	}

	static public function toFirstCharUppercase(str:String):String 
	{
		if (str == null)
			return null;
			
		var converted:String = (str.substr(0,1).toUpperCase() + (str.substr(1,str.length)));
		return converted;
	}

	static public function toUppercase(str:String):String 
	{
		if (str == null)
			return null;
			
		var converted:String = str.toUpperCase();
		return converted;
	}

	static public function enforceTwoDigitNumberToString(num:Dynamic):String 
	{
		var enf:String = "";
		if (num < 10)
			enf = "0";
		enf += Std.string(num);
		return enf;
	}

	static public function enforceThreeDigitNumberToString(num:Dynamic):String 
	{
		var enf:String = "";
		if (num < 10)
			enf = "00";
		else if (num < 100)
			enf = "0";
		enf += Std.string(num);
		return enf;
	}

	static public function enforceFourDigitNumberToString(num:Dynamic):String 
	{
		var enf:String = "";
		if (num < 10)
			enf = "000";
		else if (num < 100)
			enf = "00";
		else if (num < 1000)
			enf = "0";
		enf += Std.string(num);
		return enf;
	}
	
	static public function enforceFiveDigitNumberToString(num:Dynamic):String 
	{
		var enf:String = "";
		if (num < 10)
			enf = "0000";
		else if (num < 100)
			enf = "000";
		else if (num < 1000)
			enf = "00";
		else if (num < 10000)
			enf = "000";
		enf += Std.string(num);
		return enf;
	}
/*		
	static public function numberToStringMedFortegn(numberOrInt:*):String 
	{
		var val:Number = Convert.toNumber(numberOrInt);
		if (val > 0)
			return "+" + Convert.toString(val);
		else
			return Convert.toString(val);
	}*/

	/////////////////////////////////////////////////////////////////////////////////////
	
/*		public static function stripCharactersFromString(inputString:String, charactersToRemove:String):void
	{
		var stringToStrip:String = "(jslkkkdsssd%%M3432B)";
		//say I want to remove the (, ), M, and % characters.
		var regExp:RegExp=/[(|)|M|%]/g;
		var cleanedString:String=stringToStrip.replace(regExp, "");			
	}
*/		
	static public function fixUniCodeProblems(inStr:String):String
	{
		var mrgStr = "";
		for (c in 0...inStr.length)
		{
			var cCode:Int = StringTools.fastCodeAt(inStr, c);
			switch (cCode) 
			{
				case 229:
					mrgStr += "å";
				case 197:
					mrgStr += "Å";
				case 248:
					mrgStr += "ø";
				case 216:
					mrgStr += "Ø";
				case 230:
					mrgStr += "æ";
				case 198:
					mrgStr += "Æ";
				default:
					mrgStr += String.fromCharCode(cCode);
			}
		}
		return mrgStr;
	}	
	
	static public function countChar(inStr:String,match:String,caseSensitive:Bool=false):Int
	{
		if (inStr == null || match == null)
			return 0;
			
		var count:Int = 0;
		for (c in 0...inStr.length)
		{
			var ch:String = inStr.charAt(c);

			if (!caseSensitive)
				ch=ch.toLowerCase();
				
			if (ch==match)
				count++;
		}
		return count;
	}
	
	static public function contains(inStr:String,match:String):Bool
	{
		if (inStr == null || match == null)
			return false;
			
		return inStr.indexOf(match) !=-1;
	}
	
	static public function containsCounted(inStr:String,match:String):Int
	{
		if (inStr == null || match == null)
			return -1;
			
		var num:Int = 0;
		inStr = inStr.split(match).join("¨");
		for (i in 0...inStr.length)
		{
			if (inStr.charAt(i)=="¨")
				num++;
		}
		return num;
	}
	
	static public function returnTyped(d:String):Dynamic
	{
		if (d == null)
			return d;
			
		if (isStringBool(d))
			return Convert.toBool(d);
		else if (isStringInt(d))
			return Std.parseInt(d);
		else if (isStringInt(d))
			return Std.parseFloat(d);
		else
			return Std.string(d);
	}
	
	static public function isStringBool(inp:String):Bool
	{
		if (inp == null)
			return false;
			
		inp=inp.split(" ").join(""); // strip spaces
			
		if ((inp.toLowerCase() == "true") || (inp.toLowerCase() == "false"))
			return true;
		else
			return false;
	}
	
	static public function isStringFloat(inp:String):Bool
	{
		if (inp == null || inp.indexOf(".")==-1)
			return false;
			
		inp = inp.split(" ").join(""); // strip spaces
		inp = inp.split(".").join(""); // strip spaces
		
		return isNumeric(inp);
	}
	
	static public function isStringInt(inp:String):Bool
	{
		if (inp == null || inp.indexOf(".")!=-1)
			return false;

		inp = inp.split(" ").join(""); // strip spaces
		return isNumeric(inp);
	}
	
	static public function isfirstCharNumber(char:String):Bool
	{
		if (char==null || char.length<1)
			return false;
			
		var isNumber = false;
		var fc = char.substr(0, 1);
		switch (fc) 
		{
			case "0":
				isNumber = true;
			case "1":
				isNumber = true;
			case "2":
				isNumber = true;
			case "3":
				isNumber = true;
			case "4":
				isNumber = true;
			case "5":
				isNumber = true;
			case "6":
				isNumber = true;
			case "7":
				isNumber = true;
			case "8":
				isNumber = true;
			case "9":
				isNumber = true;
			default:
				isNumber = false;
		}
		
		return isNumber;
	}
	
	static public function cleanStringAlphaNumeric(str:String) 
	{
		if (str == null)
			return null;
			
		for (i in 0...str.length) 
		{
			var cc:Int = str.charCodeAt(i);
			//trace("--", cc);
		}
		return str;
	}
	
	static public function strListToIntArray(strList:String,?delimiter:String=","):Array<Int> 
	{
		var ra:Array<Int> = [];
		var r1:Array<String> = strList.split(delimiter);
		for (i in 0...r1.length) 
		{
			ra.push(Std.parseInt(r1[i]));
		}
		return ra;
	}
	
	static public function floatToString(float:Float,?numDecimals:Int=-1):String 
	{
		if (numDecimals ==-1)
			return Std.string(float);
		else
		{
			var sa = Std.string(float).split(".");
			if (sa.length == 1 || numDecimals==0)
			{
				var dec="";
				if (numDecimals>0)
				{
					dec+=".";
					for (i in 0...numDecimals)
						dec+="0";
				}
				return sa[0]+dec;
			}
			else
				return sa[0]+"."+sa[1].substring(0, numDecimals);
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////

    static public inline function isNumeric(str:String): Bool
    {
    	if(str == null)
    		return false;

    	return (~/^\d+$/).match(str);
    }

    static public inline function isAlpha(str:String): Bool
    {
    	if(str == null)
    		return false;
    		
    	return (~/^[A-Za-z]$/).match(str);
    }

    static public inline function isAlphaNumeric(str:String): Bool
    {
    	return (~/^[a-zA-Z0-9]+$/).match(str);
    }

	/**
	 * Same as String.split but empty strings result in an empty array
	 * Properly handles null weirdness on Flash
	 */
    static public function split(str:String, delim:String): Array<String>
    {
    	var arr = new Array<String>();
    	if(str == null || str.length == 0)
    		return arr;
    	return str.split(delim);
    }

    static public function toInitCase(str:String): String
    {
        return str.substr(0, 1).toUpperCase() + str.substr(1);
    }

    static public function formatCommas(num:Int): String
    {
        if(num < 1000)
            return Std.string(num);

        var tail = Std.string(num % 1000);
        if(tail.length < 3)
            tail = repeat("0", 3 - tail.length) + tail;
        return formatCommas(Std.int(num / 1000)) + "," + tail;
    }

    static public function formatNumber(num:Int,maxDigits:Int=-1,formatter:String="."):String
    {
        if(num < 1000)
            return Std.string(num);

        var tail = Std.string(num % 1000);
        if(tail.length < 3)
            tail = repeat("0", 3 - tail.length) + tail;

		if (maxDigits>0)
			tail = tail.substring(0, maxDigits);
		else if (maxDigits==0)
		{
			tail="";
			formatter="";
		}
        return formatCommas(Std.int(num / 1000)) + formatter + tail;
    }

    static public function repeat(toRepeat:String, count:Int): String
    {
        var str:String = "";
        for(i in 0...count)
            str += toRepeat;
        return str;
    }
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * This method parses a range string into an array of integers. 
	 * For example: 2,4-7,9 returns [2,4,5,6,7,9].
	 * However, if an array is passed, this will return that array as-is.
	 * And if an Int is passed, this will return [theInt].
	 */
    public static function parseRange(range:Dynamic):Array<Int>
    {
		#if (haxe_ver < 4.2)
        if(Std.is(range, Array))
                return cast range;

        if(Std.is(range, Int))
            return [cast(range, Int)];

        if(!Std.is(range, String))
            trace("Range string must be comma separated values: integers and hyphenated ranges");
		#else
        if(Std.isOfType(range, Array))
                return cast range;

        if(Std.isOfType(range, Int))
            return [cast(range, Int)];

        if(!Std.isOfType(range, String))
            trace("Range string must be comma separated values: integers and hyphenated ranges");
		#end

        // Treat as comma-separated string with hyphenated inclusive ranges
        var result = new Array<Int>();
        var tokens = split(range, ",");
        for(token in tokens)
        {
            // Single number
            if(token.indexOf("-") == -1)
                result.push(Std.parseInt(token));

            // Range of numbers min-max
            else
            {
                var parts = split(token, "-");
                var i = Std.parseInt(parts[0]);
                var end = Std.parseInt(parts[1]);
                result.push(i); 
                while(i != end)
                { 
                    i += (end < i ? -1 : 1);
                    result.push(i); 
                }
            }
        }
        return result;
    }  

    inline public static function nonNull(value:Dynamic, nullValue:Dynamic): Dynamic
    {
        return (value == null ? nullValue: value);
    }
	
    public static inline function randomChar(?allowedChars:String):String
    {
		if (allowedChars==null)
			return String.fromCharCode(MathUtils.getRandomIntInRange(40,140));
		else
			return randomFromArray(allowedChars.split(""));
    }
	
    public static function randomString(length:Int):String
    {
		var rst="";
		for (i in 0...length)
			rst+=randomChar();
		return rst;
    }

    inline public static function clipString(input:String, maxChars:Int, postStringIfClipped:String=""):String
    {
		return (input.length > maxChars ? input.substr(0, maxChars) + postStringIfClipped : input);
    }	
	
	/////////////////////////////////////////////////////////////////////////////////////

	static public function truncateSpace(input:String,delimiter:String=" "):String
	{
		var spa:Array<String> = input.split(" ");

		for (i in 0...spa.length)
		{
			spa.remove("\n");
			spa.remove("");
		}

		return spa.join(delimiter);
	}

	static public function remove(input:String,toRemove:Array<String>=null):String
	{
		if (toRemove!=null && toRemove.length>0)
		{
			var out:String = input;
			for (ph in toRemove)
			{
				out = StringTools.replace(out,ph,"");
			}
			return out;
		}
		else 
			return input;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function numberedName(name:String, existingNames:Array<String>):String
	{
		if (name==null)
			return null;

		if (existingNames==null || existingNames.length==0 || !existingNames.contains(name))
			return name;

		var numSameName:Int = 0;
		for (en in existingNames)
		{
			if (en!=null && en.indexOf(name)!=-1)
			{
				// trace(en,name);
				// if (StringUtils.isNumeric(en.split(name).join("")))
					// numSameName++;
			}
		}
		// trace(name+Std.string(numSameName));
		return name+Std.string(numSameName);
		// return numSameName==0?name:name+Std.string(numSameName);
		// trace(numSameName);
		// return name;
		// var nums:Array<Int> = [];
		// for (en in existingNames)
		// {
		// 	if (en!=null && en.indexOf(name)!=-1)
		// 	{
		// 		// var ns = StringTools.replace(en,name,"");
		// 		var ns = en.split(name).join("");
		// 		trace(name,en,ns);
		// 		if (StringUtils.isNumeric(ns))
		// 			nums.push(Std.parseInt(ns));
		// 	}
		// }
		// // trace(nums);
		// if (nums.length==0)
		// 	return name+"1";
		// else 
		// 	return name+Std.string(MathUtils.getHighestInt(nums));
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
/*		public static function searchReplaceBrackets(inputStr:String, searchTerms:Object, outputTarget:*=null):String
	{
		var regExp:RegExp=/[{|}]/g;
		var out:String = inputStr;
		var matches:Array = inputStr.match(/\{\w+\}/g);

		for(var i:int = 0; i < matches.length; i++)
		{
			var nMatch:String = matches[i].replace(regExp, "");	
			for (var name:String in searchTerms) 
			{
				if (nMatch == name)
					out = out.replace("{"+nMatch+"}", searchTerms[name]);
			}
		}
		if (outputTarget)
			outputTarget = out;
			
		return out;
	}
	
	public static function searchReplaceDoubleBrackets(inputStr:String, searchTerms:Object, outputTarget:*=null):String
	{
		var regExp:RegExp=/[{{|}}]/g;
		var out:String = inputStr;
		var matches:Array = inputStr.match(/\{{\w+\}}/g);

		for(var i:int = 0; i < matches.length; i++)
		{
			var nMatch:String = matches[i].replace(regExp, "");	
			for (var name:String in searchTerms) 
			{
				if (nMatch == name)
					out = out.replace("{{"+nMatch+"}}", searchTerms[name]);
			}
		}
		if (outputTarget)
			outputTarget = out;
			
		return out;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	static public function dottedPriceString(value:Number):String 
	{
		var sNR:String = value.toString();
		var fAr:Array=sNR.split(".");
		var reg:RegExp=/\d{1,3}(?=(\d{3})+(?!\d))/;

		while (reg.test(fAr[0]))
		{
			fAr[0]=fAr[0].replace(reg,"$&.");
		}
		return fAr.join(".");
	}
*/		
/*		
	static public function numberToStringMedFortegn(numberOrInt:*):String 
	{
		var val:Number = Convert.toNumber(numberOrInt);
		if (val > 0)
			return "+" + Convert.toString(val);
		else
			return Convert.toString(val);
	}*/

	/////////////////////////////////////////////////////////////////////////////////////
	
/*		public static function stripCharactersFromString(inputString:String, charactersToRemove:String):void
	{
		var stringToStrip:String = "(jslkkkdsssd%%M3432B)";
		//say I want to remove the (, ), M, and % characters.
		var regExp:RegExp=/[(|)|M|%]/g;
		var cleanedString:String=stringToStrip.replace(regExp, "");			
	}
*/		
	
	/////////////////////////////////////////////////////////////////////////////////////

}
