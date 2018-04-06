package tools.file;
import haxe.Json;

/**
 * ...
 * @author Breakyt
 */
class JsonTools 
{


	public static function getData(jsonStruct : Dynamic, field : String) : Dynamic
	{
		try
		{
			return Reflect.getProperty(jsonStruct, field);
		}
		catch (e : Dynamic)
		{
			return null;
		}
	}
	
	public static function parseJson(rawJson : String) : Dynamic
	{
		try
		{
			return Json.parse(rawJson);
		}
		catch (e : Dynamic)
		{
			return null;
		}
	}
	
}