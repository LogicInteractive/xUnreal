package lib.utils;

/**
 * ...
 * @author Tommy Svensson
 */
class XMLUtils 
{
	/************************************************************************************ 
	// XML to object / Class parser
	/************************************************************************************ 
		* // Parses an xml and returns an object or Class //////////////////////////////////
		* 
		* @param	xmlOrXmlList		The XML to be parsed
		* @param	model				Try to force into Class hierarchy  
		* @param	ignoreRootInModel	Skips the root node when parsing the model  
		* @return						The parsed Class or untyped object
		* 
		* */
	public static function xmltoType(xml:Xml,?type:Class,ignoreRootInModel:Boolean=true):Any
	{
		var rootName:String = xml.nodeName();
		trace(rootName);
		// var retObj:Object = {}
		// retObj[rootName] = parseXMLNode(xml);
		
		// if (model)
		// {
		// 	if (ignoreRootInModel)
		// 		retObj = StructParse.strongTypeToModel(retObj[rootName], model);
		// 	else
		// 		retObj = StructParse.strongTypeToModel(retObj, model);
		// }
		
		// return retObj;

		return null;
	}
/*	
	static private function parseXMLNode(xml:XML):Object 
	{
		var retNode:Object = { };
		var numNodes:int = xml.length();
		for (var i:int = 0; i < numNodes; i++) 
		{
			if (xml.children().length() == 1)
			{
				var isTextNode:String = xml[i].text().toString();
				if (isTextNode)
					retNode = isTextNode;
				else if (xml.children() is XMLList)
					retNode = parseXMLList(xml.children());
				else
					retNode = parseXMLNode(xml.children());
			}
			else if (xml.children().length() > 1)
			{
				checkLists(xml, retNode, numNodes);
			}
			else if (xml.children().length() == 0) //no children, what about attributes then?
				retNode = fetchAttributesObject(xml);
		}
		return retNode;
	}
	
	static private function parseXMLList(xmlList:XMLList):Object 
	{
		var retNode:Object = {};
		var numNodes:int = xmlList.length();
		
		for (var i:int = 0; i < numNodes; i++) 
		{
			var node:XMLList = xmlList[i].children();
			if (node && (node.length() > 0))
			{
				var nam:QName = node[i].name();
				if (xmlList[i].children().length() == 1)
				{
					var isTextNode:String = xmlList[i].text().toString();
					if (isTextNode)
					{
						if (numNodes>1)
							retNode[nam.localName] = isTextNode;
						else
							retNode = isTextNode;
					}
					else if (xmlList[i].children() is XML)
						retNode[nam.localName] = parseXMLNode(xmlList[i].children());
					else
						retNode[nam.localName] = parseXMLList(xmlList[i].children());
				}
				else if (xmlList[i].children().length() > 1)
				{
					checkLists(xmlList[i], retNode, numNodes);
				}
			}
		}
		return retNode;
	}
	
	static private function checkLists(xmlNode:XML, retNode:Object, numNodes:int):void 
	{
		var retStatus:Boolean = false;
		var namesO:Object = { };
		for (var n:int = 0; n < xmlNode.children().length(); n++) 
		{
			var nnam:QName = xmlNode.children()[n].name();
			if (namesO[nnam]==undefined)
				namesO[nnam] = 1;
			else
				namesO[nnam]++;
		}

		var nic:int = 0;
		for (var n1:String in namesO) 
		{
			if (namesO[n1] > 1)
			{
				retNode[n1] = [];
				for (var i:int = 0; i < namesO[n1] ; i++) 
				{
					retNode[n1].push(parseXMLNode(xmlNode.children()[i+nic]));
				}
				nic = i;
			}
			else
				retNode[n1] = parseXMLList(xmlNode[n1]);
		}
		
	}
	
	static private function fetchAttributesObject(xml:XML):Object 
	{
		var retObj:Object = {};
		for each (var att:XML in xml.@ * )
		{
			retObj["" + att.name ()] = "" + att.valueOf();
		}
		return retObj;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	public static function strongTypeToModel(obj:Object, model:*=null):*
	{
		var ret:*;
		
		if (model && (model is Class))
		{
			ret = new model();
			setStrongTypedProperties(ret, obj);
		}
		else 
			ret = obj;
			
		return ret;
	}
	
	static private function setStrongTypedProperties(model:Object, obj:Object):void 
	{
		if (obj is Array)
		{
			if (model)
			{
				var modelItem:* = ObjUtils.getTypeClassFromTypedArray(model);
				for (var i:int = 0; i < obj.length; i++) 
				{
					var modelArrayType:* = new modelItem;
					ObjUtils.copyProperties(obj[i], modelArrayType, false, true);
					model.push(modelArrayType);
					////model.push(obj[i]);
					////setStrongTypedProperties(model[i], obj[i]);
				}
			}
		}
		else
		{
			for (var name:String in obj) 
			{
				setModelProperty(name, model, obj[name]);
				//if (name in model)
					//setStrongTypedProperties(model[name], obj[name]);
			}
		}
	}
	
	static private function setModelProperty(propName:String, model:Object, value:*=null):void 
	{
		if (propName in model)
		{
			var desc:XML = describeType(model);
			var varClass:String = desc..variable.(@name == propName).@type.toString();
			switch (varClass.toLowerCase()) 
			{
				case "string":
					model[propName] = Convert.toString(value);
					break;
				case "boolean":
					model[propName] = Convert.toBoolean(value);
					break;
				case "int":
					model[propName] = Convert.toInt(value);
					break;
				case "number":
					model[propName] = Convert.toNumber(value);
					break;
				//case "array":
					//model[propName] = Convert.toArray(value);
					//break;
				default:
					//try
					//{
						model[propName] = new (getDefinitionByName(varClass) as Class);
						setStrongTypedProperties(model[propName], value);
					//}
					//catch (e:Error)
					//{
						
					//}
			}
		}
	}
	*/
	/////////////////////////////////////////////////////////////////////////////////////
}