package standard.group.graphic;

import core.component.ComponentGroup;
import standard.components.graphic.display.GameElementDisplay;
import standard.components.space2d.Depth;

/**
 * ...
 * @author Breakyt
 */
class GameElementGroup extends ComponentGroup 
{
	public var gameElement : GameElementDisplay;
	public var depth : Depth;
	
	public function new() 
	{
		super();
		this.bindFieldType(GameElementDisplay, "gameElement");
		this.bindFieldType(Depth, "depth");
	}
	
}