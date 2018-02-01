package standard.group.input;

import core.component.ComponentGroup;
import standard.components.input.PointerBehaviourComponent;

/**
 * ...
 * @author Breakyt
 */
class PointerBehaviourGroup extends ComponentGroup 
{

	public var behaviour : PointerBehaviourComponent;
	
	public function new() 
	{
		super();
		this.bindFieldType(PointerBehaviourComponent, "behaviour"); 	
	}
	
}