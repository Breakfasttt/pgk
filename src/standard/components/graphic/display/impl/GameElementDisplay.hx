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
	 * The Parent entity name. If parent entity have a display, 'this' Display is added to the Display list of the parent entity
	 * If entity not found or have no display, 'this' Display will not be add to the display list
	 */
	public var entityParentName(default, set) : String;
	
	public var entityParentChange(default,null) : Signal0;
	
	/**
	 * @param	entityLayerName : the name of the Layer Parent Entity. if not exist, Gameelement will be added to the Stage instead of a layer
	 * @param	model
	 */
	public function new(entityParentName : String, model:Model) 
	{
		super();
		entityParentChange = new Signal0();
		this.entityParentName = entityParentName;
		this.setModel(model);
	}
	
	function set_entityParentName(value:String):String 
	{
		if (value != entityParentName)
		{
			entityParentName = value;
			entityParentChange.dispatch;
		}
		return entityParentName = value;
	}
}