package lib.types;

class ExtendedTypes
{
}

typedef PercentageFloatInt = OneOf<PercentageFloat, PercentageInt>;
typedef PercentageFloat = OneOf<Percentage, Float>;
typedef PercentageInt = OneOf<Percentage, Int>;
typedef Percentage = String;

typedef PathOrBytes = OneOf<String, haxe.io.Bytes>;
// typedef PathOrBlob = OneOf<String, kha.Blob>;

typedef Func = ()->Void;

abstract OneOf<A, B>(haxe.ds.Either<A, B>) from haxe.ds.Either<A, B> to haxe.ds.Either<A, B>
{
	@:from inline static function fromA<A, B>(a:A) : OneOf<A, B> return haxe.ds.Either.Left(a);
	@:from inline static function fromB<A, B>(b:B) : OneOf<A, B> return haxe.ds.Either.Right(b);

	@:to inline function toA():Null<A> return switch(this) {case haxe.ds.Either.Left(a): a; default: null;}
	@:to inline function toB():Null<B> return switch(this) {case haxe.ds.Either.Right(b): b; default: null;}
}
