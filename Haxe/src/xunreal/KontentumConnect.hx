package xunreal;

import lib.kontentum.KontentumDataTypes.KontentumStatus;
import lib.kontentum.Kontentum;
import haxe.Timer;
import unreal.*;

@:keep
class KontentumConnect extends unreal.BPLatentTaskNode
{
	/////////////////////////////////////////////////////////////////////////////////////

	public function new(ip:String,exhibitToken:String,clientID:String)
	{
		super();

		Kontentum.onComplete=onKontentumReady;
		Kontentum.onFail=onKontentumFail;

		if (clientID!=null && clientID!="")
			Kontentum.clientID = clientID;

		Kontentum.connect(
			exhibitToken,
			ip,
			null,
			false,
			false,
			false,
			true,
			null
		);		
	}

	function onKontentumReady()
	{
		trace(Kontentum.RESTJson);
		taskComplete();
	}

	function onKontentumFail(status:KontentumStatus)
	{
		trace("Connection to Kontentum failed.",true);
		trace(status);
		taskFailed();
	}

	/////////////////////////////////////////////////////////////////////////////////////
}
