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
	
	public function new(name : String, mainResourcePath : String, type : ModelType, jsonData : String) : Void
	{
		this.name = name;
		this.mainResourcePath = mainResourcePath;
		this.type = type;
		
		if (jsonData == null || jsonData == "")
			this.jsonData = null;
		else
		{
		
			try
			{
				this.jsonData = Json.parse(jsonData);
			}
			catch (e : Dynamic)
			{
				trace("WARNING : Json parsing failed for model : " + this.name + " reason : " + e);
				this.jsonData = null;
			}
		}
	}
}