package unreal;

import lib.utils.ObjUtils;
import unreal.types.DynamicWrapper;

@:nogenerate
class UObjectBase
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new()
	{
	}

	/////////////////////////////////////////////////////////////////////////////////////

	@:noCompletion
	static public function processIncomingDelegate(p:UObjectBase,delegateInfo:IncomingDelegateInfo)
	{
		if (delegateInfo==null)
			return;

		var params:Array<Dynamic> = [
			delegateInfo.param1!=null?delegateInfo.param1.getValue():null,
			delegateInfo.param2!=null?delegateInfo.param2.getValue():null,
			delegateInfo.param3!=null?delegateInfo.param3.getValue():null
		];

		for (f in Reflect.fields(p))
		{
			var n = ObjUtils.getName(Reflect.field(p,f));
			if (n=="unreal.DynamicMulticastDelegate" && f==delegateInfo.delegateName)
			{
				var dg = Reflect.field(p,f);
				if (dg!=null)
					dg.trigger(delegateInfo.delegateName,delegateInfo.numParams,params);
			}
		}
	}

	@:noCompletion
	static public function setDelegateOwners(p:UObjectBase)
	{
		for (f in Reflect.fields(p))
		{
			var n = ObjUtils.getName(Reflect.field(p,f));
			if (n=="unreal.DynamicMulticastDelegate")
			{
				var dg:DynamicMulticastDelegate<Dynamic> = Reflect.field(p,f);
				if (dg!=null)
				{
					@:privateAccess dg.name = f;
					@:privateAccess dg.parent = p;
					if (Reflect.field(p,"owner")!=null)
						@:privateAccess dg.owner = Reflect.field(p,"owner");
				}
			}
		}
	}

	/////////////////////////////////////////////////////////////////////////////////////
}

typedef IncomingDelegateInfo =
{
	delegateName:String,
	numParams:Int,
	param1:cpp.Star<DynamicWrapper>,
	param2:cpp.Star<DynamicWrapper>,
	param3:cpp.Star<DynamicWrapper>	
}