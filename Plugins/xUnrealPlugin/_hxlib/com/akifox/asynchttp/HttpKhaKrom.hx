package com.akifox.asynchttp;

/**
 * ...
 * @author Tommy S.
 */

#if kha_krom
//import haxe.io.Bytes;

class HttpKhaKrom extends haxe.http.HttpBase
{
	public function new(url:String)
	{
		super(url);
	}

	public function cancel()
	{
	}

	public override function request(?post:Bool)
	{
	}
}
#end
