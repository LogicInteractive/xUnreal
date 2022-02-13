package unreal;

@:include('./HxUnrealExt.h')
@:cppInclude('UeExtG.cpp')
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
