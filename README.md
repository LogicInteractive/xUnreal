
# xUnreal 🦾👀

Fast portable Haxe development in Unreal Engine. Sounds like just a dream? Maybe. 
But this project is a start of something. Time will show how usable this will be...

![image](https://user-images.githubusercontent.com/1677550/176910275-edd9ab7a-57d5-465d-a80a-549ccb7d218a.png)

# NOTE! THIS PLUGIN IS IN DEVELOPMENT AND IS NOT READY FOR USE YET!!

This project aims to be able to:

 - Compatible with UE5
 - Compile Haxe code fast to a static library that can be included and used within Unreal
 - Be portable and be able to compile the Unreal project without having Haxe or the Haxe source code
 - Work with any version of Unreal Engine
 - Be extendable
 - Be fast, convenient and easy to work with
 - Provide optional simplified actions for easier Unreal development
 - Use hxcpp with Unreal to make Haxe code run at native speed

There are limitations in play for now here; communication between Haxe code and Unreal is somewhat basic yet. Unreal types and classes needs manual glue templates to interface and only basic types will work for now, but there are workarounds and this will improve over time. Also, macro generated glue code is needed.
Haxe is included with the project.

This project does not intend to replace C++ or Blueprints, you should still use that when you need some specific Unreal functions. 

Its not the ultimate solution, but for now ... its a working start.

Examples of some basic usage below :

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
    @:uproperty(BlueprintReadOnly)
    public var speed		: Float;

    public function new()
    {
        super();
    }

    override public function BeginPlay()
    {
        y = (Math.random()*800)-400;
        x = (Math.random()*800)-400;
        speed = 0.1+(Math.random()*2);
    }

    override public function EndPlay()
    {
        trace("actor goodbye");
    }

    override public function Tick(deltaSeconds:Float)
    {
        var time = unreal.World.getTimeSeconds();
        setActorLocation(Math.sin(time*speed)*200,0,Math.cos(time*speed)*100+100);
        setActorRotation(0,0,Math.sin(time*2*speed)*360);

        z = Math.sin(time*speed*2.0)*200+200;
        scale=Math.sin(time*speed*0.5)*360;

        rotationZ+=speed;
        super.Tick(deltaSeconds);
    }
}


class TestLevel2 extends LevelScriptActor
{
    public function new()
    {
        super();
    }

    override public function BeginPlay()
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
        http.onError = function(e)
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

    override public function NativeConstruct()
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
}

```

This project is based on Haxe-C-Bridge : https://github.com/haxiomic/haxe-c-bridge
