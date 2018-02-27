package standard.group.graphic.display;

import core.component.ComponentGroup;
import standard.components.graphic.display.impl.PopUp;

/**
 * ...
 * @author Breakyt
 */
class PopUpGroup extends ComponentGroup 
{
	public var popup : PopUp;
	
	public function new() 
	{
		super();
		this.bindFieldType(PopUp, "popup");
	}
	
}