package standard.group.graphic;

import core.component.ComponentGroup;
import standard.components.graphic.Display;
import standard.components.space2d.Depth;
import standard.components.space2d.Pivot2D;
import standard.components.space2d.Position2D;
import standard.components.space2d.Scale2D;
import standard.components.space2d.UtilitySize2D;

/**
 * A group managed by DisplayModule. See it for more details
 * @author Breakyt
 */
class DisplayGroup extends ComponentGroup 
{
	public var display : Display;
	public var position : Position2D;
	public var pivot : Pivot2D;
	public var utilitySize : UtilitySize2D;
	public var scale : Scale2D;
	public var depth : Depth;
	
	public function new() 
	{
		super();
		this.bindFieldType(Display, "display");
		this.bindFieldType(Position2D, "position");
		this.bindFieldType(Pivot2D, "pivot");
		this.bindFieldType(UtilitySize2D, "utilitySize");
		this.bindFieldType(Scale2D, "scale");
		this.bindFieldType(Depth, "depth");
	}
	
}