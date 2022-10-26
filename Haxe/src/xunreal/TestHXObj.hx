package xunreal;

import unreal.types.StringArray;
import unreal.types.FloatArray;
import unreal.types.IntArray;
import unreal.types.Vector2D;
import unreal.types.HaxeArray;
import haxe.Timer;
import unreal.*;

class TestHXObj extends unreal.Object
{
	/////////////////////////////////////////////////////////////////////////////////////

	var timer:Timer;

	var delegate:DynamicMulticastDelegate<String->Void> = {};
	var delegateTest2:DynamicMulticastDelegate<String->Float->Bool->Void> = {};

	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
		super();
		trace("wazzup!!!");

		delegate.add(onDelegate);
		delegateTest2.add(onDelegate2);

		timer = new Timer(500);
		timer.run = ding;
	}

	function ding()
	{
		// trace('Ohoy '+Math.random());
		// GEngine.dispatchEvent("MY_EVENT",'Hello string : ${Math.random()}');
		delegate.broadcast("nisse!!");
		delegateTest2.broadcast("nisse!!",3.14,true);
	}

	override function destructor()
	{
		trace("im dead!!");
		timer.stop();
		timer = null;
	}

	function onDelegate(str:String)
	{
		trace('Yes : $str');
	}
	
	function onDelegate2(p1:String,p2:Float,p3:Bool)
	{
		trace('OMG!!! : $p1 : $p2 : $p3');
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function gettArray():IntArray
	{
		return IntArray.create([97,84,36,25,87,21]);
	}	

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function setInts(ints:IntArray)
	{
		trace(ints.toString());
	}	

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function setFloat(floats:FloatArray)
	{
		trace(floats.toString());
	}	

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function setStrings(strings:StringArray)
	{
		trace(strings.toString());
	}	

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function gettArray2():FloatArray
	{
		return FloatArray.create([0.6,0.4,0.2]);
	}	

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function getStrArray():StringArray
	{
		return StringArray.create(["We are","testing","array","strings"]);
	}	

	@:ufunction(BlueprintCallable, Category="xUnreal")
	public function getTest():Vector2D
	{
		var v = Vector2D.stackAlloc();
		v.x = 1;
		return v;
	}	

	/////////////////////////////////////////////////////////////////////////////////////
}
