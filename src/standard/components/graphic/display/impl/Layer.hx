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
	/**
	 * You can specify your own DisplayObjectContainer. By default : Sprite()
	 * @param	container
	 */
	public function new(container : DisplayObjectContainer = null) 
	{
		super();
		
		if (this.model == null)	
			this.model = new EmptyModel();
	}
	
}