package standard.components.graphic.display.impl;

import standard.components.graphic.display.Display;

/**
 * PopUps is a Ui element added on display list with "stack" comportement. (First in First out)
 * Its a display without model, you must attach popup's element manually (skin.addhcild) or using gameElement.parentEntityName = "mypopup"
 * It's better to add a fixed Utility Size for entity with popup display.
 * @author Breakyt
 */
class PopUp extends Display 
{
	public function new() 
	{
		super();
	}
}