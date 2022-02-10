package;

import cpp.ConstCharStar;
import cpp.ConstCharStar;
import cpp.NativeString;
import unreal.GEngine;
import unreal.LevelScriptActor;

class TestLevel2 extends LevelScriptActor
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
	}

	override public function BeginPlay()
	{
		// var t = new haxe.Timer(500);
		// t.run = ()-> trace("'ello "+Math.random());

		trace("Hello level.");
	}

	override public function EndPlay()
	{
		trace("Goodbye level.");
	}

	override public function Tick(deltaSeconds:Float)
	{
		// trace(deltaSeconds);
	}

	function loadTest()
	{
		var http = new haxe.Http("http://kontentum.link/rest/getexhibit/84l1dr");
		http.onData = function(data) {
			var result = haxe.Json.parse(data);
			GEngine.addOnScreenDebugMessage(-1,15,null,result);
		}
		http.onError = function(e) {
			GEngine.addOnScreenDebugMessage(-1,15,null,"failed!");
		}
		http.request();		
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
