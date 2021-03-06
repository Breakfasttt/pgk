package standard.group.graphic.display;

import core.component.ComponentGroup;
import standard.components.graphic.display.impl.PopUp;
import standard.components.graphic.transition.Opener;
import standard.components.graphic.transition.impl.EntityTransition;

/**
 * ...
 * @author Breakyt
 */
class PopUpGroup extends ComponentGroup 
{
	public var popup : PopUp;
	public var opener : Opener;
	
	public function new() 
	{
		super();
		
		this.bindFieldType(PopUp, "popup");
		
		this.bindOptionalFieldType(Opener, "opener");
	}
	
}