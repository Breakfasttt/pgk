package standard.group.input;

import core.component.ComponentGroup;
import standard.components.input.PointerBehavioursComponent;

/**
 * ...
 * @author Breakyt
 */
class PointerBehaviourGroup extends ComponentGroup 
{

	public var behaviours : PointerBehavioursComponent;
	
	public function new() 
	{
		super();
		this.bindFieldType(PointerBehavioursComponent, "behaviours"); 	
	}
	
}