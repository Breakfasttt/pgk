package assets.model.library;
import haxe.Json;
import openfl.Assets;
import tools.file.PathTools;

/**
 * ...
 * @author Breakyt
 */
class ModelDataLoader 
{

	private var m_modelDescriptorFilePath : String;
	
	public function new(modelDescriptorFilePath : String) 
	{
		m_modelDescriptorFilePath = modelDescriptorFilePath;
	}
	
	public function loadModelData() : Array<ModelData>
	{
		if ( PathTools.getExtension(m_modelDescriptorFilePath) != "json")
		{
			trace("ERROR :: The models descriptor file is not a JSON - return empty array");
			return [];
		}
		
		var datasString : String = Assets.getText(m_modelDescriptorFilePath);
		
		if (datasString == null)
		{
			trace("ERROR :: The models descriptor doesn't exist. REturn empty array");
			return [];
		}
		
		var dataJson : Array<Dynamic> = null;
		
		try
		{
			dataJson = Json.parse(datasString);
		}
		catch (e : Dynamic)
		{
			trace("ERROR :: Can't parse models descriptor. Return empty array");
			return [];	
		}
		
		var result : Array<ModelData> = new Array<ModelData>();
		var tempData : ModelData = null;
		var modelType : ModelType = null;
		var modelJsonData : String = "";
		
		for (modelData in dataJson)
		{
			modelType = this.getModelTypeWithExtention(modelData.mainResourcePath);
			
			if (modelType == ModelType.spriteSheet)
				modelJsonData = this.getJsonData(modelData.mainResourcePath);
			else
				modelJsonData = "";
			
			tempData = new ModelData(modelData.name, modelData.mainResourcePath, modelType, modelJsonData);
			result.push(tempData);
		}
		
		return result;
	}
	
	
	private function getModelTypeWithExtention(modelMainRessource : String) : ModelType
	{
		var ext : String = PathTools.getExtension(modelMainRessource);
		ext = ext.toLowerCase();
		
		switch(ext)
		{
			case "jpg" : return ModelType.simple;
			case "jpeg" : return ModelType.simple;
			case "png" : return ModelType.simple;
			case "spritesheet" : return ModelType.spriteSheet;
			default : return ModelType.unknow;
		}
		
		return ModelType.unknow;
	}
	
	private function getJsonData(modelMainRessource : String)  : String
	{
		return Assets.getText(modelMainRessource);
	}
	
}