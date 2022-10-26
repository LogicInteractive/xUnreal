package lib.utils;

class ArrayUtils 
{
	/////////////////////////////////////////////////////////////////////////////////////
	
	public static function shuffleInPlace<T>(arr:Array<T>): Void
	{
        var i:Int = arr.length, j:Int, t:T;
        while (--i > 0)
        {
			t = arr[i];
			arr[i] = arr[j = MathUtils.rndInt(0, arr.length - 1)];
			arr[j] = t;
        }
	}

	/* Shuffles an array */
	public static function shuffle<T>( array : Array<T> ) : Array<T>
	{
		// http://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
		var currentIndex : Int = array.length;
		var randomIndex : Int = -1;
		var temporaryValue : Dynamic;

		// While there remain elements to shuffle...
		while ( 0 != currentIndex ) {

			// Pick a remaining element...
			randomIndex = Std.int( Math.random() * currentIndex );
			--currentIndex;

			// And swap it with the current element.
			temporaryValue = array[ currentIndex ];
			array[ currentIndex ] = array[ randomIndex ];
			array[ randomIndex ] = temporaryValue;
		}

		return array;
	}

	public static function anyOneOf<T>(arr:Array<T>): T
	{
		if(arr == null || arr.length == 0)
			return null;
		return arr[MathUtils.rndInt(0, arr.length - 1)];
	}

	/**
	 * Like Array.filter but returns an array of indices to the array (keys), rather than the array valuentityService.
	 * Also, the comparison func receives an array index, not an array value.
	 */
    public static function indexFilter<T>(arr:Array<T>, func:Int->Bool): Array<Int>
    {
    	var result = new Array<Int>();
    	for(i in 0...arr.length)
    	{
    		if(func(i))
    			result.push(i);
    	}
    	return result;
    }

    public static function find<T>(arr:Array<T>, obj:T): Int
    {
    	for(i in 0...arr.length)
    		if(arr[i] == obj)
    			return i;
    	return -1;
    }

	/**
		Returns `true` if an array contains the `value`. Otherwise `false`.
	**/
	public static inline function contains<T>( array : Array<T>, value : T ) : Bool {

		return ( array.indexOf( value ) != -1 );
	}
		
	/**
		Returns `true` if an array contains the exact same values. Otherwise `false`.
	**/
	public static function equals<T>( array : Array<T>, arrayB : Array<T> ) : Bool {

		if ( array != null && arrayB != null ) {

			// Same instance
			if ( array == arrayB ) return true;

			if ( array.length == arrayB.length ) {

				var c : Int = array.length;
				if ( 0 < c ) {

					for ( i in 0...c ) {

						if ( array[ i ] != arrayB[ i ] ) {

							return false;
						}
					}
				}

				return true;
			}
		}

		return false;
	}

	public static function insertAll<T>( toArray : Array<T>, fromArray : Array<T>, pos : Int ) : Array<T> {

		var i : Int = fromArray.length - 1;
		while ( 0 <= i ) {

			toArray.insert( pos, fromArray[ i ] );
			--i;
		}

		return toArray;
	}

	public static function pushAvoidNull<T>(array : Array<T>, x: T ) : Array<T> {

		if ( x != null ) {

			array.push( x );
		}
		return array;
	}

	public static function popAll<T>( array : Array<T> ) : Array<T> {

		if ( array != null ) {

			var all : Array<T> = [];
			while ( 0 < array.length ) {

				all.push( array.pop() );
			}
			return all;
		}
		return null;
	}

	public static function pushAll<T>( toArray : Array<T>, fromArray : Array<T> ) : Array<T> {

		for ( i in 0...fromArray.length ) {

			toArray[ toArray.length ] = fromArray[ i ];
		}

		return toArray;
	}

	public static inline function remove<T>( array : Array<T>, value : T ) : Int {

		var index : Int = array.indexOf( value );
		if ( index != -1 ) {

			array.splice( index, 1 );
		}
		return index;
	}

	public static inline function removeDuplicates<T>( array : Array<T> ) : Int {

		var unique : Array<T> = [];
		var removed : Int = 0;

		var i : Int = 0;
		while ( i < array.length ) {

			var value : T = array[ i ];
			if ( ArrayUtils.contains( unique, value ) ) {

				removed++;
				array.splice( i, 1 );
			}
			else {

				unique.push( value );
				i++;
			}
		}
		return removed;
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
	