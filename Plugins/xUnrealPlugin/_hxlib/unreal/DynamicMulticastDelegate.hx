package unreal;

import cpp.Native;
import haxe.Constraints.Function;
import lib.utils.ObjUtils;
import unreal.types.DynamicWrapper;

@:structInit
@:cppFileCode('
#include <../../../_hxlib/unreal/types/DynamicWrapper.h>
void _delegateBroadcast(void* owner, const char* delegateName);
void _callDynamicMulticastDelegateByName(void* owner, const char* delegateName, DynamicWrapper* param1, DynamicWrapper* param2, DynamicWrapper* param3);
')
class DynamicMulticastDelegate<T:Function>
{
	/////////////////////////////////////////////////////////////////////////////////////

    var name:String;
    var parent:UObjectBase;
	var owner:cpp.Pointer<cpp.Void>;    
    var callBacks:Array<T> = [];

	/////////////////////////////////////////////////////////////////////////////////////

    public function new()
	{
    }

	/////////////////////////////////////////////////////////////////////////////////////

    public function add(f:T)
    {
        callBacks.push(f);
    }

    public function remove(f:T)
    {
        if (callBacks.contains(f))
            callBacks.remove(f);
    }

    public function broadcast(...params:Dynamic)
    {
        switch params.length
        {
            case 0  : untyped __global__._callDynamicMulticastDelegateByName(owner.ptr,name,null,null,null);
            case 1  : untyped __global__._callDynamicMulticastDelegateByName(owner.ptr,name,DynamicWrapper.create(params[0]).ref(),null,null);
            case 2  : untyped __global__._callDynamicMulticastDelegateByName(owner.ptr,name,DynamicWrapper.create(params[0]).ref(),DynamicWrapper.create(params[1]).ref(),null);
            case 3  : untyped __global__._callDynamicMulticastDelegateByName(owner.ptr,name,DynamicWrapper.create(params[0]).ref(),DynamicWrapper.create(params[1]).ref(),DynamicWrapper.create(params[2]).ref());
            case _  :
        }
    }

	/////////////////////////////////////////////////////////////////////////////////////

    @:keep
    function trigger(delegateName:String,numParams:Int=0,params:Array<Dynamic>)
    {
        for (cf in callBacks)
        {
            var cb:Function = cf;
            if (cb!=null)
            {
                if (numParams==0)
                    cb();
                else if (numParams==1 && params.length>0)
                    cb(params[0]);
                else if (numParams==2 && params.length>1)
                    cb(params[0],params[1]);
                else if (numParams==3 && params.length>2)
                    cb(params[0],params[1],params[2]);
                // else if (numParams==4 && params.length>3)
                //     cb(params[0],params[1],params[2],params[3]);
                // else if (numParams==5 && params.length>4)
                //     cb(params[0],params[1],params[2],params[3],params[4]);
            }
        }
    }

	/////////////////////////////////////////////////////////////////////////////////////
}