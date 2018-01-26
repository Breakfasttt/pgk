package standard.group.graphic;

import core.component.ComponentGroup;
import standard.components.graphic.Display;
import standard.components.graphic.Representation;

/**
 * A group managed by RepresentationModule.
 * @author Breakyt
 */
class RepresentationGroup extends ComponentGroup 
{

	public var display : Display;
	public var representation : Representation;
	
	public function new() 
	{
		super();
		this.bindFieldType(Display, "display");
		this.bindFieldType(Representation, "representation");
		
	}
	
}