package standard.group.graphic.render;

import core.component.ComponentGroup;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.Display;
import standard.components.space2d.Pivot2D;

/**
 * ...
 * @author Breakyt
 */
class AnimRenderGroup extends ComponentGroup 
{
	public var display : Display;
	public var animation : Animation;
	public var pivot : Pivot2D;
	
	public function new() 
	{
		super();
		
		this.bindFieldType(Display, "display");
		this.bindFieldType(Pivot2D, "pivot");
		
		this.bindOptionalFieldType(Animation, "animation");
	}
	
}