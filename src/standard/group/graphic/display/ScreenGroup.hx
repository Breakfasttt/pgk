package standard.group.graphic.display;

import core.component.ComponentGroup;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.transition.Opener;

/**
 * ...
 * @author Breakyt
 */
class ScreenGroup extends ComponentGroup 
{

	public var screen : Screen;
	
	public var opener : Opener;
	
	//maybe add a camera ?
	
	public function new() 
	{
		super();
		
		this.bindFieldType(Screen, "screen");
		
		this.bindOptionalFieldType(Opener, "opener");
	}
	
}