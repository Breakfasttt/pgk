package standard.components.graphic.display.impl;
import assets.model.Model;
import assets.model.impl.SimpleModel;
import flash.display.Sprite;
import msignal.Signal.Signal0;
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
	 * @param	entityLayerName : the name of the Layer Parent Entity. if not exist, Gameelement will be added to the Stage instead of a layer
	 * @param	model
	 */
	public function new(model:Model) 
	{
		super();
		this.setModel(model);
	}
}