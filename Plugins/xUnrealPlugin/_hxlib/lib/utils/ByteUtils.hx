package lib.utils;

import haxe.io.Bytes;

class ByteUtils 
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	public static function copyTo( bytes : Bytes, pos : Int, length : Int, target : Bytes, targetPos : Int  ) : Void
	{

		for ( i in 0...length )
		{

			target.set( targetPos + i, bytes.get( pos + i ) );
		}
	}

	public static function indexOfString( bytes : Bytes, string : String , ?startIndex : Int = 0 ) : Int
	{

		var stringLength : Int = string.length;
		var endIndex : Int = bytes.length - stringLength;
		var index : Int = startIndex;

		while ( index <= endIndex )
		{

			var indexString : String = bytes.getString( index, stringLength );
			if ( indexString == string )
			{

				return index;
			}

			++index;
		}

		return -1;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
	