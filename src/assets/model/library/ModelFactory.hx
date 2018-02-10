package assets.model.library;
import assets.model.Model;
import assets.model.impl.EmptyModel;
import assets.model.impl.SimpleModel;

/**
 * ...
 * @author Breakyt
 */
class ModelFactory 
{

	public function new() 
	{
		
	}
	
	public function createModel(modelData : ModelData) : Model
	{
		switch(modelData.type)
		{
			case ModelType.unknow :
			{
				return createEmptyModel(modelData);
			}
			case ModelType.empty :
			{
				return createEmptyModel(modelData);
			}
			case ModelType.simple :
			{
				return createEmptyModel(modelData);
			}
		}
	}
	
	
	private function createEmptyModel(modelData : ModelData) : Model
	{
		return new EmptyModel(modelData);	
	}
	
	private function createSimpleModel(modelData : ModelData) : Model
	{
		return new SimpleModel(modelData);
	}
	
	
}