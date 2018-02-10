package assets.model.library;
import haxe.Json;

/**
 * ...
 * @author Breakyt
 */
class ModelData 
{
	public var name(default, null) : String;
	
	public var type(default, null) : ModelType;
	
	public var mainResourcePath(default, null) : String;
	
	public var jsonData(default, null) : Dynamic;
	
	public function new(name : String, mainResourcePath : String, type : String, jsonData : String) : Void
	{
		this.name = name;
		this.mainResourcePath = mainResourcePath;
		
		try
		{
			this.type = Type.createEnum(ModelType, type);
		}
		catch (e : Dynamic)
		{
			this.type = ModelType.unknow;
		}
		
		try
		{
			this.jsonData = Json.parse(jsonData);
		}
		catch (e : Dynamic)
		{
			this.jsonData = null;
		}
	}
}