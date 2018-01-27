package standard.components.graphic;

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
	/**
	 * You can specify your own DisplayObjectContainer. By default : Sprite()
	 * @param	container
	 */
	public function new(container : DisplayObjectContainer = null) 
	{
		super();
		
		if (this.skin == null)	
			this.skin = new Sprite();
	}
	
}