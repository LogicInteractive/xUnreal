
  

#  xUnreal 🦾

  

This project is a prototype of a way to do interoperable Haxe development in Unreal Engine.

![image](https://user-images.githubusercontent.com/1677550/176910275-edd9ab7a-57d5-465d-a80a-549ccb7d218a.png)

What does this mean? It means you can code in Haxe and the code will be compiled to a .lib that is included in the UE project, thanks to [Haxe-C-Bridge](https://github.com/haxiomic/haxe-c-bridge).

Using macro code, Unreal specific code is generated for bindings and this is compiled with the engine. 
Out of the box there is some basic functional templates for common Unreal specific actors, widgets, blueprints etc.

If you need heavy unreal specific code, this has to be manually tied in, or just use blueprints!  
  

This project aims to be able to:

- Provide fast Unreal compilation, since only changing @:uclass / @:ufunction / @:property fields will trigger the need for recompilation of those classes 
- Make your Haxe code supplement Blueprints / C++ - it is not intended to replace them.
- Compile Haxe code fast to a static library that can be included and used within Unreal
- Provide basic communication back / to UE and C++ / Blueprints
- Be portable and be able to compile the Unreal project without having Haxe or the Haxe source code
- Work with any version of Unreal Engine
- Be extendable
- Be fast, convenient and easy to work with
- Provide optional simplified actions for easier Unreal development
- Use hxcpp with Unreal to make Haxe code run at native speed
- Add support for unreal delegates in a very convenient way using Haxe macros. 

#  Some examples of some basic usage below :

  

```haxe

class BPFuncDataApi extends unreal.BlueprintFunctionLibrary
{
	public function new()
	{
		super();
	}

	@:ufunction(BlueprintCallable, Category="IO")
	static public function Trace(input:String)
	{
		trace(input);
	}
}

@:uclass(Blueprintable,Deprecated,meta=[BlueprintSpawnableComponent,ChildCanTick])
class TestActor extends unreal.Actor
{
	var myEvent : DynamicMulticastDelegate<Int->Void> = {};

	@:uproperty(BlueprintReadOnly)
	public var speed  :  Float;

	public function new()
	{
		super();
	}

	override public function BeginPlay()
	{
		myEvent.add(delegateReceiver);
		y  = (Math.random()*800)-400;
		x  = (Math.random()*800)-400;
		speed  =  0.1+(Math.random()*2);
		myEvent.broadcast(12345);
	}

	override public function EndPlay()
	{
		trace("actor goodbye");
	}

	override public function Tick(deltaSeconds:Float)
	{
		var  time  =  unreal.World.getTimeSeconds();
		setActorLocation(Math.sin(time*speed)*200,0,Math.cos(time*speed)*100+100);
		setActorRotation(0,0,Math.sin(time*2*speed)*360);
		z  =  Math.sin(time*speed*2.0)*200+200;
		scale=Math.sin(time*speed*0.5)*360;
		rotationZ+=speed;
		
		super.Tick(deltaSeconds);
	}

	function delegateReceiver(value:Int)
	{
		trace(value);
	} 
}

class TestLevel2 extends LevelScriptActor
{
	public function new()
	{
		super();
	}

	override  public  function  BeginPlay()
	{
		trace("Hello level.");
		loadTest();
	}

	override public function EndPlay()
	{
		trace("Goodbye level.");
	}

	override public function Tick(deltaSeconds:Float)
	{
	}

	function loadTest()
	{
		var http = new haxe.Http("<someHTTPcall>");
		http.onData = function(data)
		{
			var result = haxe.Json.parse(data);
			GEngine.addOnScreenDebugMessage(-1,15,null,result);
		}
		http.onError =  unction(e)
		{
			GEngine.addOnScreenDebugMessage(-1,15,null,"failed!");
		}
		http.request();
	}
}

class TestUserWidget extends unreal.UserWidget
{

	public function new()
	{
		super();
	}

	override public function  NativeConstruct()
	{
		trace("Hello widget!! ================= >> ");
	}

	@:ufunction(BlueprintPure)
	public function getSomeText():String
	{
		return 'The time is : ${Math.random()}';
	}

	@:ufunction(BlueprintCallable)
	public function getSomeInt():Int
	{
		return Std.int(127*Math.random());
	}

	@:ufunction(BlueprintCallable)
	public function getSomeFloat():Float
	{
		return Math.random();
	}

	@:ufunction(BlueprintPure,CallInEditor)
	public function getSomeBool():Bool
	{
		return Math.random()>0.5;
	}
	
	override function OnPaint()
	{
		drawCircle(100,100,50,0xffffff,true,1);
		drawRect(0,0,200,100,0xffffff,true,3);
		drawText('Hello Slate drawing', 120,180);
		drawLine(50,200,400,250,0x55ffffff);
	}
}

  

```
This project makes use of Haxe-C-Bridge : https://github.com/haxiomic/haxe-c-bridge
