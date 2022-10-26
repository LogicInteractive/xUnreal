package lib.utils;

import lib.types.Object;

/**
 * ...
 * @author Tommy S.
 */

 class ObjUtils
{
	/////////////////////////////////////////////////////////////////////////////////////

	static public inline function getClassName(input:Dynamic,?fullPath:Bool=true):String
	{
		if (fullPath)
			return Type.getClassName(Type.getClass(input));
		else
			return Type.getClassName(Type.getClass(input)).split(".").pop();
	}

	static public function getTopLevelClass(input:Class<Dynamic>):Class<Dynamic>
	{
		var ret:Class<Dynamic> = input;

		while (true)
		{
			var sc:Class<Dynamic> = Type.getSuperClass(ret);
			if (sc==null)
				return ret;

			ret = sc;
		}

		return input;
	}

	static public function createClassFromPath(classPath:String,?args:Array<Dynamic>):Dynamic
	{
		if (classPath==null || classPath=="")
			return null;

		if (args==null)
			args=[];

		classPath = classPath.split(" ").join(""); //We dont want spaces here!!
		var classDefinition = Type.resolveClass(classPath);

		if (classDefinition==null)
		{
			trace('Could not resolve class: "' + classPath+'".');			
			return null;
		}

		var c:Dynamic = null;
		try
		{
			c = Type.createInstance(classDefinition,args);	
		}
		catch(e:haxe.Exception)
		{
			trace('Failed to create class "' + classPath+'".');
		}
		return c;
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
	public static function toString(obj:Dynamic):String
	{
		if (obj == null)
			return null;
			
		var retStr = "";
		for (name in Reflect.fields(obj))
		{		
			var val = Reflect.getProperty(obj, name);
			retStr += '"' + name+'":' + Std.string(val) + ", ";
		}
		return retStr.substr(0,retStr.length-2);
	}
	
	public static inline function copyProperty(propertyName:String,source:Dynamic,dest:Dynamic=null):Dynamic
	{
		if (source!=null)
		{
			if (dest==null)
				dest = {};
			
			if (Reflect.hasField(source,propertyName))
				Reflect.setProperty(dest, propertyName, Reflect.getProperty(source, propertyName));
		}
		
		return dest;
	}
	
	public static function copyProperties(source:Dynamic,dest:Dynamic=null,deepCopy:Bool=true,checkIfHasProperty:Bool=false):Dynamic
	{
		if (source!=null)
		{
			if (dest==null)
				dest = {};
			
			var destFields = Reflect.fields(dest);
			for (name in Reflect.fields(source))
			{
				try
				{
					if (checkIfHasProperty)
					{
						if (destFields.indexOf(name)!=-1)
						{
							Reflect.setProperty(dest, name, Reflect.getProperty(source, name));
						}
					}
					else
					{
						Reflect.setProperty(dest, name, Reflect.getProperty(source, name));
					}
				}
				catch(e:Dynamic)
				{
					//.... Failed to set property... but so what..?
				}
			}
		}
		
		return dest;
	}
	
	public static function getObjLength(obj:Dynamic):Int
	{
		var nums:Int = 0;
		if (obj!=null)
		{
			for (name in Reflect.fields(obj))
			{
				nums++;
			}
		}
		return nums;
	}
	
	public static function isEmpty(obj:Dynamic):Bool
	{
		if (obj == null)
			return true;
			
		return Reflect.fields(obj).length == 0;
	}

	public static function getName(thing:Any):String
	{
		if (thing==null)
			return "null";		
		else 
		{
			var s:String = Type.getClassName(thing);
			if (s==null)
			{
				var cl = Type.getClass(thing);
				if (cl!=null)
					s = Type.getClassName(cl);
			}
			if (s==null)
				return "null";
			else 
				return s;			
		}
	}

/*
	public static function clone(reference:*) : Object
	{
		var clone:ByteArray = new ByteArray();
		clone.writeObject( reference );
		clone.position = 0;

		return clone.readObject();
	}
	
	static public function getTypeClassFromTypedArray(source:Object):Class 
	{
		var returnClass:Class;
		var desc:XML = describeType(source);
		var typeName:String = desc.@name;
		var baseName:String = desc.@base;
		if (baseName && (baseName.indexOf("<*>") != -1))
		{
			var bn2:String = baseName.split("*")[0];
			var typeClassName:String = typeName.split(bn2)[1].slice(0,-1);
			returnClass = getDefinitionByName(typeClassName) as Class;
		}
		else
			returnClass = Object;
		
		return returnClass;
	}
*/
	public static function hasProperty(obj:Dynamic, propertyName:String, checkForNullValue:Bool=true):Bool
	{
		if (obj!=null && propertyName!=null)
		{
			var keys = Reflect.fields(obj);
			if (keys.indexOf(propertyName) !=-1)
			{
				if (checkForNullValue)
				{
					if (Reflect.getProperty(obj,propertyName) != null)
						return true;
				}
				else
				{
					return true;
				}
						
			}
		}
		return false;
	}
	
	static public function getRandomPropertyName(obj:Dynamic):String 
	{
		if (obj == null)
			return null;
			
		var oLen:Int = getObjLength(obj);
		var rnd:Int = Std.int(Math.random() * oLen);
		var cc:Int = 0;
		for (name in Reflect.fields(obj))
		{
			if (cc >= rnd)
			{
				return name;
			}
			cc++;
		}
		return null;
	}
	
	static public function propertyNamesToArray(obj:Dynamic, ?check:Dynamic=null):Array<Dynamic>
	{
		var retArr:Array<Dynamic> = [];
		if (obj!=null)
		{
			for (name in Reflect.fields(obj))
			{		
				if (check != null)
				{
					if (Reflect.getProperty(obj, name) == check)
						retArr.push(name);
				}
				else
					retArr.push(name);
			}
		}
		return retArr;			
	}
	
	static public function fromXML(xml:Xml,skipRootChild:Bool=false):Object
	{
		var o:Object = new Object();
		if (xml != null)
		{
			if (skipRootChild && xml.firstChild()!=null)	
				iterateXMLNode(o, xml.firstChild());
			else
				iterateXMLNode(o, xml);
		}
		return o;
	}
	
	static private function iterateXMLNode(o:Object, xml:Xml) 
	{
		for ( node in xml.elements() )
		{
			if (node!=null)
			{	
				var nodeChildren = 0;
				for ( nc in node.elements() )
					nodeChildren++;
					
				if (nodeChildren>0)
				{
					o[node.nodeName] = new Object();
					iterateXMLNode(o[node.nodeName], node);
				}
				else
					o[node.nodeName] = StringUtils.returnTyped(Std.string(node.firstChild()));
			}
		}		
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
	static public function getFieldByObjectPath(object:Dynamic, objectPath:String):Dynamic
	{
		if (object != null && objectPath != null)
		{
			var splitPath:Array<String> = objectPath.split(".");
			if (splitPath != null)
			{
				var dItr:Dynamic = object;
				for (i in 0...splitPath.length) 
				{
					if (Reflect.hasField(dItr, splitPath[i]))
					{
						dItr = Reflect.field(dItr, splitPath[i]);
						if (dItr == null)
							return null;
					}
					else
						return null;
				}
				return dItr;
			}
		}
		return null;
	}
	
	static public function setFieldByObjectPath(object:Dynamic, objectPath:String, value:Dynamic)
	{
		if (object != null && objectPath != null)
		{
			var splitPath:Array<String> = objectPath.split(".");
			if (splitPath != null)
			{
				var dItr:Dynamic = object;
				for (i in 0...splitPath.length-1) 
				{
					if (!Reflect.hasField(dItr, splitPath[i]))
						Reflect.setField(dItr, splitPath[i], {});
						
					dItr = Reflect.field(dItr, splitPath[i]);
				}
				if (dItr!=null)
					Reflect.setField(dItr, splitPath[splitPath.length-1], value);
			}
		}
	}
	
	public static function setProperties(source:Dynamic,dest:Dynamic):Dynamic
	{
		if (source==null || dest==null)
			return dest;
			
		for (name in Reflect.fields(source))
		{
			// try
			// {
				var s = Reflect.getProperty(source, name);
				// if (Std.isOfType(s,Reflect.field(dest,name)))
					// Reflect.setProperty(dest, name, Reflect.getProperty(source, name));
				// else
					// Reflect.setProperty(dest, name, Convert.auto(Reflect.getProperty(source, name),Reflect.field(dest,name)));
				Reflect.setProperty(dest, name, cast Reflect.getProperty(source, name));
			// }
			// catch(e:haxe.Exception)
			// {
			// 	trace(e.stack);
			// }
		}
		
		return dest;
	}

	public static function setPropertiesSafe(source:Dynamic,dest:Dynamic):Dynamic
	{
		if (source==null || dest==null)
			return dest;
			
		for (name in Reflect.fields(source))
		{
			// try
			// {
				if (hasFieldNamed(dest,name))
				{
					var s = Reflect.getProperty(source, name);
					// if (Std.isOfType(s,Reflect.field(dest,name)))
						// Reflect.setProperty(dest, name, Reflect.getProperty(source, name));
					// else
						// Reflect.setProperty(dest, name, Convert.auto(Reflect.getProperty(source, name),Reflect.field(dest,name)));
					Reflect.setProperty(dest, name, cast Reflect.getProperty(source, name));
				// }
				}
			// catch(e:haxe.Exception)
			// {
			// 	trace(e.stack);
			// }
		}
		
		return dest;
	}
	
	public static function hasFieldNamed(object:Dynamic, fieldName:String):Bool
	{
		var c:Class<Dynamic> = Type.getClass(object);
		while(c != null)
		{
			if (Type.getInstanceFields(c).indexOf(fieldName) >= 0 || Type.getClassFields(c).indexOf(fieldName) >= 0)
				return true;
			c = Type.getSuperClass(c);
		}
		return false;
	}

	/////////////////////////////////////////////////////////////////////////////////////
	
/*
	public static function clone(reference:*) : Object
	{
		var clone:ByteArray = new ByteArray();
		clone.writeObject( reference );
		clone.position = 0;

		return clone.readObject();
	}
	
	static public function getTypeClassFromTypedArray(source:Object):Class 
	{
		var returnClass:Class;
		var desc:XML = describeType(source);
		var typeName:String = desc.@name;
		var baseName:String = desc.@base;
		if (baseName && (baseName.indexOf("<*>") != -1))
		{
			var bn2:String = baseName.split("*")[0];
			var typeClassName:String = typeName.split(bn2)[1].slice(0,-1);
			returnClass = getDefinitionByName(typeClassName) as Class;
		}
		else
			returnClass = Object;
		
		return returnClass;
	}
*/
	
	static public function toArray(obj:Dynamic):Array<Dynamic> 
	{
		var retArr:Array<Dynamic> = [];
		if (obj)
		{
			for (name in Reflect.fields(obj))
			{		
				var val = Reflect.getProperty(obj, name);
				retArr.push(val);
			}
		}
		return retArr;			
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
}

