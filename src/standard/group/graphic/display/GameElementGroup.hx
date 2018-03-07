package standard.group.graphic.display;

import core.component.ComponentGroup;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.misc.ParentEntity;
import standard.components.space2d.Depth;

/**
 * ...
 * @author Breakyt
 */
class GameElementGroup extends ComponentGroup 
{
	public var gameElement : GameElementDisplay;
	public var depth : Depth;
	
	public var parentEntity : ParentEntity;
	
	public function new() 
	{
		super();
		this.bindFieldType(GameElementDisplay, "gameElement");
		this.bindFieldType(Depth, "depth");
		
		this.bindOptionalFieldType(ParentEntity, "parentEntity");
	}
	
}