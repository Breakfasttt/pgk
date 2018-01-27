package standard.components.graphic;

import core.component.Component;
import flash.display.DisplayObjectContainer;
import openfl.display.Sprite;

/**
 * A layer is a Display object Container added to the displayList
 * where other Display is added
 * @author Breakyt
 */
class Layer extends Component 
{
	public var container : DisplayObjectContainer;
		
	/**
	 * You can specify your own DisplayObjectContainer. By default : Sprite()
	 * @param	container
	 */
	public function new(container : DisplayObjectContainer = null) 
	{
		super();
		
		this.container = container;
		
		if (this.container == null)	
			this.container = new Sprite();
		
	}
	
}