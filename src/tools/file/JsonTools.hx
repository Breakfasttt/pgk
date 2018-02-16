package tools.file;

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
	
}