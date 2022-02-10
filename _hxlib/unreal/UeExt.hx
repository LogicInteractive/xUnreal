package unreal;

@:include('./HxUnrealExt.h')
extern class UeExt
{
	/////////////////////////////////////////////////////////////////////////////////////

	@:native("printToScreen")
	public static function printToScreen(inp:String):Void;

	@:native("logMessage")
	public static function logMessage(inp:String):Void;

	@:native("_setActorLocation")
	public static function _setActorLocation(owner:cpp.Star<cpp.Void>,x:Float,y:Float,z:Float):Void;

	@:native("_setActorRotation")
	public static function _setActorRotation(owner:cpp.Star<cpp.Void>,x:Float,y:Float,z:Float):Void;

	@:native("_setActorScale3D")
	public static function _setActorScale3D(owner:cpp.Star<cpp.Void>,x:Float,y:Float,z:Float):Void;

	/////////////////////////////////////////////////////////////////////////////////////
}

/* @:native("FString")
extern class FString
{

}

@:native("FColor")
extern class FColor
{

}

@:native("FVector2D")
extern class FVector2D
{

}

@:include('./HxUnrealExt.h')
// @:native('GEngine')
extern class GEngineExt
{
	/////////////////////////////////////////////////////////////////////////////////////

	@:native('GEngine->AddOnScreenDebugMessage(-1, 10.f, FColor::Green, TEXT("YO MAN!!!"))')
	public static function AddOnScreenDebugMessage():Void;
	// public static function AddOnScreenDebugMessage(Key:cpp.Int32, TimeToDisplay:cpp.Float32, DisplayColor:FColor, DebugMessage:FString, bNewerOnTop:Bool, TextScale:FVector2D):Void;

	/////////////////////////////////////////////////////////////////////////////////////
} */