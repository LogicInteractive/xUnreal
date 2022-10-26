package lib.utils;

import lib.types.Color;
import lib.types.math.FastVector4;

/**
 * ...
 * @author 
 */
/* 
typedef ColorVal =
{
	?value	: UInt,
	?r		: UInt,
	?g		: UInt,
	?b		: UInt,
	?a		: UInt
}
  */
class ColorUtils
{
	/////////////////////////////////////////////////////////////////////////////////////
	
		/////////////////////////////////////////////////////////////////////////////////////
		
		public static function toHexString(color:Color):String
		{
			// var uc:UInt = cast color;

			// var a:String = @:privateAccess extractAlpha(color).toString(16).toUpperCase();
			// var r:String = @:privateAccess extractRed(color).toString(16).toUpperCase();
			// var g:String = @:privateAccess extractGreen(color).toString(16).toUpperCase();
			// var b:String = @:privateAccess extractBlue(color).toString(16).toUpperCase();
			// if (a.length == 1)
			// 	a = "0" + a;
			// if (r.length == 1)
			// 	r = "0" + r;
			// if (g.length == 1)
			// 	g = "0" + g;
			// if (b.length == 1)
			// 	b = "0" + b;

			var a:String = StringTools.hex(extractAlpha(color),2);
			var r:String = StringTools.hex(extractRed(color),2);
			var g:String = StringTools.hex(extractGreen(color),2);
			var b:String = StringTools.hex(extractBlue(color),2);

			return "#" + a + r + g + b;
		}

		/////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Returns the value of red in the specified color (0 - 255).
		 * 
		 * @param $color The color, in hexadecimal format, to extract the red value from
		 * 
		 * @return uint
		 */
		public static inline function extractRed(color:UInt):UInt
		{
			return ((color >> 16) & 0xFF);
		}
		
		/**
		 * Returns the value of green in the specified color (0 - 255).
		 * 
		 * @param $color The color, in hexadecimal format, to extract the green value from
		 * 
		 * @return uint
		 */
		public static inline function extractGreen(color:UInt):UInt
		{
			return ((color >> 8) & 0xFF);
		}
		
		/**
		 * Returns the value of blue in the specified color (0 - 255).
		 * 
		 * @param $color The color, in hexadecimal format, to extract the blue value from
		 * 
		 * @return uint
		 */
		public static inline function extractBlue(color:UInt):UInt
		{
			return (color & 0xFF);
		}
		
		/**
		 * Returns the value of alpha in the specified color (0 - 255).
		 * 
		 * @param $color The color, in hexadecimal format, to extract the blue value from
		 * 
		 * @return uint
		 */
		public static inline function extractAlpha(color:UInt):UInt
		{
			return ((color >> 24 ) & 0xFF);
		}
		
		/**
		 * Combines red, blue, and green components into a color value.
		 * 
		 * @param $r The red value
		 * @param $g The green value
		 * @param $b The blue value
		 * 
		 * @return uint The numerical representation of the combined colors
		 */
		public static inline function combineRGB(r:UInt, g:UInt, b:UInt):UInt
		{
			return ((r << 16) | (g << 8) | b);
		}
		
		/**
		 * Combines alpha, red, blue, and green components into a color value.
		 * 
		 * @param $a The alpha value
		 * @param $r The red value
		 * @param $g The green value
		 * @param $b The blue value
		 * 
		 * @return uint The numerical representation of the combined colors
		 */
		public static inline function combineARGB(a:UInt, r:UInt, g:UInt, b:UInt):UInt
		{
			return ((a << 24) | (r << 16) | (g << 8) | b);
		}
		
		/**
		 * Displays the specified numerical representation of a color (RGB) as a hexadecimal string.
		 * 
		 * @param $color The numerical value of a color
		 * 
		 * @return String The color represented in hexadecimal RGB
		 */
/*		public static function displayRGBasHex(color:UInt):String
		{
			var r:String = extractRed(color).toString(16).toUpperCase();
			var g:String = extractGreen(color).toString(16).toUpperCase();
			var b:String = extractBlue(color).toString(16).toUpperCase();
			var zero:String = "0";
			
			if (r.length == 1) r = zero.concat(r);
			if (g.length == 1) g = zero.concat(g);
			if (b.length == 1) b = zero.concat(b);
			
			return String(r + g + b);
		}*/
		
		/**
		 * Displays the specified numerical representation of a color (ARGB) as a hexadecimal string.
		 * 
		 * @param $color The numerical value of a color
		 * 
		 * @return String The color represented in hexadecimal ARGB
		 */
/*		public static function displayARGBasHex(color:UInt):String
		{
			var a:String = extractAlpha(color).toString(16).toUpperCase();
			var r:String = extractRed(color).toString(16).toUpperCase();
			var g:String = extractGreen(color).toString(16).toUpperCase();
			var b:String = extractBlue(color).toString(16).toUpperCase();
			var zero:String = "0";
			
			if (a.length == 1) a = zero.concat(a);
			if (r.length == 1) r = zero.concat(r);
			if (g.length == 1) g = zero.concat(g);
			if (b.length == 1) b = zero.concat(b);
			
			return String(a + r + g + b);
		}*/
	

	public static function hexToRgbArray( hexString : String, ?rgb : Array<Int> = null ) : Array<Int>
	{

		if ( hexString.indexOf( "#" ) == 0 )
		{
			hexString = hexString.substr( 1 );
		}

		if ( hexString.length == 3 )
		{
			hexString = hexString.charAt(0) + hexString.charAt(0) + hexString.charAt(1) + hexString.charAt(1) + hexString.charAt(2) + hexString.charAt(2);
		}
		else if ( hexString.length != 6 )
		{
			trace( 'Invalid hex color: ' + hexString );
			return [0];
		}

		if ( rgb == null )
		{
			rgb = [];
		}

		for ( i in 0...3 )
		{
			rgb[ i ] = Std.parseInt( "0x" + hexString.substr( i * 2, 2 ) );
		}

		return rgb;
	}

	public static function luminanaceFromHex( hexString : String ) : Float
	{
		var rgb : Array<Int> = hexToRgbArray( hexString );
		return luminanaceFromRgb( rgb[ 0 ], rgb[ 1 ], rgb[ 2 ] );
	}

	public static function luminanaceFromRgb( r : Int, g : Int, b : Int ) : Float
	{

		var a = [ r, g, b].map( function( v : Float )
		{
			v /= 255;
			return ( v <= 0.03928 ) ? v / 12.92 : Math.pow( ((v+0.055)/1.055), 2.4 );
		});

		return a[ 0 ] * 0.2126 + a[ 1 ] * 0.7152 + a[ 2 ] * 0.0722;
	}

	public static inline function fromHexString( hexString : String ) : Int
	{

		if ( hexString.indexOf( "#" ) == 0 )
		{
			hexString = "0x" + hexString.substr( 1 );
		}

		return Std.parseInt( hexString );
	}

	public static function interpolate( fromColor : Int, toColor : Int, progress : Float ) : Int
	{
		var q : Float = 1 - progress;
		var fromA : Int = (fromColor >> 24) & 0xFF;
		var fromR : Int = (fromColor >> 16) & 0xFF;
		var fromG : Int = (fromColor >> 8) & 0xFF;
		var fromB : Int = fromColor & 0xFF;

		var toA : Int = (toColor >> 24) & 0xFF;
		var toR : Int = (toColor >> 16) & 0xFF;
		var toG : Int = (toColor >> 8) & 0xFF;
		var toB : Int = toColor & 0xFF;

		var resultA : Int = Std.int( fromA * q + toA * progress );
		var resultR : Int = Std.int( fromR * q + toR * progress );
		var resultG : Int = Std.int( fromG * q + toG * progress );
		var resultB : Int = Std.int( fromB * q + toB * progress );
		var resultColor : Int = resultA << 24 | resultR << 16 | resultG << 8 | resultB;

		return resultColor;
	}

	/////////////////////////////////////////////////////////////////////////////////////

	#if kha

	static public inline function multiply(colorA:kha.Color,colorB:kha.Color):kha.Color 
	{
		var nColor:kha.Color = kha.Color.White;
		nColor.A = colorA.A*colorB.A;
		nColor.R = colorA.R*colorB.R;
		nColor.G = colorA.G*colorB.G;
		nColor.B = colorA.B*colorB.B;
		return nColor;
	}

	#end

	/////////////////////////////////////////////////////////////////////////////////////
	
/*	static public function RGBToHex(r:Int, g:Int, b:Int):String
	{
		var sr = r.toString(16);
		var sg = g.toString(16);
		var sb = b.toString(16);

		if (sr.length == 1)
			sr = "0" + r;
		if (sg.length == 1)
			sg = "0" + g;
		if (sb.length == 1)
			sb = "0" + b;

		return "#" + sr + sg + sb;
	}
	*/
	/////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * A linear interpolator for hex colors.
	 *
	 * @param {Number} a  (hex color start val)
	 * @param {Number} b  (hex color end val)
	 * @param {Number} amount  (the amount to fade from a to b)
	 *
	 * @example
	 * // returns 0x7f7f7f
	 * lerpColor(0x000000, 0xffffff, 0.5)
	 *
	 * @returns {Number}
	 */
/*	static public function lerpColorRGB(a:UInt, b:UInt, amount:Float):UInt
	{
		var ar:Int = a >> 16;
		var ag:Int = a >> 8 & 0xff;
		var ab:Int = a & 0xff;

		var br:Int = b >> 16;
		var bg:Int = b >> 8 & 0xff;
		var bb:Int = b & 0xff;

		var rr:Float = ar + amount * (br - ar);
		var rg:Float = ag + amount * (bg - ag);
		var rb:Float = ab + amount * (bb - ab);

		return (rr << 16) + (rg << 8) + (rb | 0);
	}*/

	static public inline function colorToFV4(color:Color):FastVector4
	{
		return new FastVector4(color.R,color.G,color.B,color.A);
	}

	static public function lerpColor(a:Color, b:Color, amount:Float, lerpAlpha:Bool=true):Color
	{
		//var cca:UInt = a.value;
		//var ar = a >> 16,
		//var ag = a >> 8 & 0xff,
		//var ab = a & 0xff,
//
		//var br = b >> 16,
		//var bg = b >> 8 & 0xff,
		//var bb = b & 0xff,

		var rr = a.R + amount * (b.R - a.R);
		var rg = a.G + amount * (b.G - a.G);
		var rb = a.B + amount * (b.B - a.B);
		
		var ra = a.A;
		if (lerpAlpha)
			ra+=(amount*(b.A-a.A));

		return Color.fromFloats(rr, rg, rb, ra);
	}

	static public function randomColor():Color 
	{
		var r:UInt = Math.round(Math.random() * 0xffffff) + 0xff000000;
		return Color.fromValue(r);
	}
	
	static public inline function blendColors(from:Color, to:Color, amount:Float, blendAlpha:Bool=true):Color 
	{
		return lerpColor(from,to,amount,blendAlpha);
	}
	
/* 	static public function multiply(colorA:Color,colorB:Color):Color 
	{
		var nColor:Color = Color.White;
		nColor.A = colorA.A*colorB.A;
		nColor.R = colorA.R*colorB.R;
		nColor.G = colorA.G*colorB.G;
		nColor.B = colorA.B*colorB.B;
		return nColor;
	} */
	

	/////////////////////////////////////////////////////////////////////////////////////

}