package standard.components.graphic.display.impl;
import flash.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import openfl.utils.Assets;

/**
 * A GameElementDisplay is sort with classic depth on the displayList
 * It's a representation of a game object on a 'scene'
 * Like avatar, ennemies, etc.
 * @author Breakyt
 */
class GameElementDisplay extends Display 
{
	
	/**
	 * The Entity who contains a Layer where the Display is added to the Display List
	 * If layer not found or Null, the Display will not be add to the display list
	 */
	public var entityLayerName : String;
		
	/**
	 * The name of the model
	 */
	public var modelName(default,null) : String;
	
	public function new(entityLayerName : String, modelName:String) 
	{
		super();
		this.entityLayerName = entityLayerName;
		this.modelName = modelName;
		applyModel();
	}
	
	private function removeModel() : Void
	{
		if(this.skin != null)
			this.skin = null;
	}	
	
	public function setModel(modelName : String) : Void
	{
		//todo 
	}
	
	private function applyModel() : Void
	{
		removeModel();
		
		if (!Assets.exists(this.modelName, AssetType.IMAGE))
		{
			trace("Warning : Can't find " + this.modelName  + ". A Random Colored Square 50*50 is created for this display");
			this.skin = this.createSquare();
		}
		else
		{
			//todo => manage many type of model (animation, bitmap, movieclip, etc)
			var bmd : BitmapData = Assets.getBitmapData(this.modelName);
			this.skin = new Sprite(); 
			this.skin .addChild(new Bitmap(bmd));
		}
	}
	
}