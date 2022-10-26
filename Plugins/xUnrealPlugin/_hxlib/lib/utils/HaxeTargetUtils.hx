package lib.utils;

package de.superclass.haxe.util;

class HaxeTargetUtils
{
    public static var CPP : String = "cpp";
    public static var CS : String = "cs";
    public static var EVAL : String = "eval";
    public static var FLASH : String = "flash";
    public static var HL : String = "hl";
    public static var JAVA : String = "java";
    public static var JS : String = "js";
    public static var LUA : String = "lua";
    public static var NEKO : String = "neko";
    public static var PHP : String = "php";
    public static var PHP7 : String = "php7";
    public static var PYTHON : String = "python";
    public static var UNKNOWN : String = "unknow";

    public static function getTarget() : String {

        var t : String = UNKNOWN;

        #if cpp

        t = CPP;

        #elseif cs

        t = CS;

        #elseif eval

        t = EVAL;

        #elseif flash

        t = FLASH;

        #elseif hl

        t = HL;

        #elseif java

        t = JAVA;

        #elseif js

        t = JS;

        #elseif lua

        t = LUA;

        #elseif neko

        t = NEKO;

        #elseif php7

        t = PHP7;

        #elseif php

        t = PHP;

        #elseif python

        t = PYTHON;

        #end

        return t;
    }
}