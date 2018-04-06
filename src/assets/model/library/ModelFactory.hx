package assets.model.library;
import assets.model.Model;
import assets.model.impl.EmptyModel;
import assets.model.impl.FlashSpriteSheet;
import assets.model.impl.SimpleModel;
import assets.model.impl.SpriteSheetModel;
import assets.model.impl.TimelineModel;

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
				return createSimpleModel(modelData);
			}
			case ModelType.timeline :
			{
				return createTimeLineModel(modelData);
			}
			case ModelType.spriteSheet :
			{
				return createSpriteSheetModel(modelData);
			}
			case ModelType.flashSpriteSheet :
			{
				return createFlashSpriteSheetModel(modelData);
			}
			default : 
			{
				return createEmptyModel(modelData);
			}
		}
	}
	
	
	private function createEmptyModel(modelData : ModelData) : Model
	{
		return new EmptyModel(modelData.name);	
	}
	
	private function createSimpleModel(modelData : ModelData) : Model
	{
		return new SimpleModel(modelData);
	}
	
	private function createSpriteSheetModel(modelData : ModelData) : Model
	{
		return new SpriteSheetModel(modelData);
	}
		
	private function createFlashSpriteSheetModel(modelData : ModelData) : Model
	{
		return new FlashSpriteSheet(modelData);
	}
	
	private function createTimeLineModel(modelData : ModelData) : Model
	{
		return new TimelineModel(modelData);
	}
	
	
}