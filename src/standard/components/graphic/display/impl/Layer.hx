package standard.components.graphic.display.impl;

import assets.model.Model;
import assets.model.impl.EmptyModel;
import assets.model.impl.SimpleModel;
import assets.model.library.ModelData;
import core.component.Component;
import flash.display.DisplayObjectContainer;
import openfl.display.Sprite;
import standard.components.graphic.display.Display;

/**
 * A layer is a Display object Container added to the displayList
 * where other Display is added
 * @author Breakyt
 */
class Layer extends Display 
{
	
	public var mask(default, null) : Sprite;
	
	/**
	 * A layer is a Display without model attach only on the Stage.
	 * If you want an empty display use Screen.hx or Popup.hx display.
	 * @param	container
	 */
	public function new() 
	{
		super();
		mask = new Sprite();
		mask.graphics.beginFill(0xff0000, 1);
		mask.graphics.drawRect(0, 0, 1, 1);
		mask.graphics.endFill();
	}
	
}