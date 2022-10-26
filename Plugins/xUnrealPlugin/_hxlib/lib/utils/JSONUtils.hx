package lib.utils;

import haxe.Json;

class JsonUtils
{

	public static function escapeString( string : String ) : String {

		string = StringUtil.replace( string, "\\", "\\\\" );
//		string = StringUtil.replace( string, "\b", "\\b" ); Invalid escape sequence \b
//		string = StringUtil.replace( string, "\f", "\\f" ); Invalid escape sequence \f
		string = StringUtil.replace( string, "\n", "\\n" );
		string = StringUtil.replace( string, "\r", "\\r" );
		string = StringUtil.replace( string, "\t", "\\t" );
		string = StringUtil.replace( string, "\"", "\\\"" );

		return string;
	}

	public static function prettify( object : Dynamic, tab : String, lineBreak : String, colonPrefix : String, colonSuffix : String, linePrefix : String, ?maxDepth : Int = -1, ?depth : Int = 0 ) : String
	{
		// NULL
		if ( object == null )
		{
			return "NULL";
		}

		// String
		if ( Std.isOfType( object, String ) )
		{
			// With "
			return "\"" + escapeString( object ) + "\"";
		}

		// BOOL
		if ( Std.isOfType( object, Bool ) )
		{
			return ( object == true ) ? "true" : "false";
		}

		// Number
		if ( Std.isOfType( object, Float ) || Std.isOfType( object, Int ) )
		{
			// Without "
			return "" + object;
		}

		if ( maxDepth != -1 )
		{
			if ( depth == maxDepth )
			{
				return "\"" + "MAX_DEPTH_REACHED_(" + maxDepth + ")" + "\"";
			}
			else
			{
				++depth;
			}
		}

		// Array
		if ( Std.isOfType( object, Array ) )
		{
			// Start on same line
			var arrayString : String = "[";

			var array : Array<Dynamic> = cast object;
			var arrayLength : Int = array.length;
			var arrayLastItem : Int = arrayLength - 1;
			for ( i in 0...arrayLength ) {

				// Each entry on new line and one level deeper
				arrayString += lineBreak + linePrefix + tab + prettify( array[ i ], tab, lineBreak, colonPrefix, colonSuffix, linePrefix + tab, maxDepth, depth );

				// Add separator
				if ( i != arrayLastItem )
				{
					arrayString += ",";
				}
			}

			// End on new line
			arrayString += lineBreak + linePrefix + "]";
			return arrayString;
		}

		// Object

		// Start on same line
		var objectString : String = "{";

		var fields : Array<String> = Reflect.fields( object );
			fields.sort( ArrayUtil.sortFunctionAscending );

		var fieldsLength : Int = fields.length;
		var fieldsLastItem : Int = fieldsLength - 1;

		for ( i in 0...fields.length )
		{
			var field : String = fields[ i ];
			// Each entry on new line and one level deeper
			objectString += lineBreak + linePrefix + tab + "\"" + field + "\"" + colonPrefix + ":" + colonSuffix + prettify( ReflectUtil.getField( object, field ), tab, lineBreak, colonPrefix, colonSuffix, linePrefix + tab, maxDepth, depth );
			// Add separator
			if ( i != fieldsLastItem )
			{
				objectString += ",";
			}
		}

		objectString += lineBreak + linePrefix + "}";
		return objectString;
	}

	public static inline function prettifyMax( object : Dynamic, ?tab : String = "\t", ?lineBreak : String = "\n", ?colonPrefix : String = " ", ?colonSuffix : String = " ", ?linePrefix : String = "", ?maxDepth : Int = -1, ?depth : Int = 0 ) : String
	{
		return prettify( object, tab, lineBreak, colonPrefix, colonSuffix, linePrefix, maxDepth, depth );
	}


	public static inline function prettifyMin( object : Dynamic, ?tab : String = "", ?lineBreak : String = "", ?colonPrefix : String = "", ?colonSuffix : String = "", ?linePrefix : String = "", ?maxDepth : Int = -1, ?depth : Int = 0 ) : String
	{
		return prettify( object, tab, lineBreak, colonPrefix, colonSuffix, linePrefix, maxDepth, depth );
	}

	public static function tryParse( jsonString, ?errorHandler : Dynamic -> Void = null ) : Dynamic
	{
		var jsonData : Dynamic = null;
		try
		{
			jsonData = Json.parse( jsonString );
		}
		catch( e : Dynamic )
		{
			if ( errorHandler != null )
			{
				errorHandler( e );
			}
			return null;
		}

		return jsonData;
	}
}
