
# xUnreal

Fast portable Haxe development in Unreal Engine. Sounds like just a dream? Maybe. 
But this project is a start of something. Time will show how usable this will be...

This project aims to be able to:

 - Compile Haxe code fast to a static library that can be included and used within Unreal
 - Be portable and be able to compile the Unreal project without having Haxe or the Haxe source code
 - Work with any version of Unreal Engine
 - Be extendable
 - Be fast, convenient and easy to work with
 - Provide optional simplified actions for easier Unreal development
 - Use hxcpp with Unreal to make Haxe code run at native speed

There are limitations in play for now here; communication between Haxe code and Unreal is somewhat basic yet. Unreal types and classes needs manual glue templates to interface and only basic types will work for now, but there are workarounds and this will improve over time. Also, macro generated glue code is needed.

This project does not intend to replace C++ or Blueprints, you should still use that if you need some specific Unreal functions in your code. 

Its not the ultimate solution, but for now ... its a working start.

This project is based on Haxe-C-Bridge : https://github.com/haxiomic/haxe-c-bridge
