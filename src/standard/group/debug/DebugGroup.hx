package standard.group.debug;

import core.component.ComponentGroup;
import standard.components.debug.DebugComp;

/**
 * ...
 * @author Breakyt
 */
class DebugGroup extends ComponentGroup 
{

	public var debugComp : DebugComp;
	
	public function new() 
	{
		super();
		this.bindFieldType(DebugComp, "debugComp");
	}
	
}