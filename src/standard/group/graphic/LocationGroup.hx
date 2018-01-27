package standard.group.graphic;

import core.component.ComponentGroup;
import standard.components.graphic.display.Display;
import standard.components.space2d.Depth;
import standard.components.space2d.Pivot2D;
import standard.components.space2d.Position2D;
import standard.components.space2d.Scale2D;
import standard.components.space2d.UtilitySize2D;

/**
 * A group managed by DisplayModule. See it for more details
 * @author Breakyt
 */
class LocationGroup extends ComponentGroup 
{
	public var display : Display;
	public var position : Position2D;
	public var pivot : Pivot2D;
	public var utilitySize : UtilitySize2D;
	public var scale : Scale2D;
	
	public function new() 
	{
		super();
		this.bindFieldType(Display, "display");
		this.bindFieldType(Position2D, "position");
		this.bindFieldType(Pivot2D, "pivot");
		this.bindFieldType(UtilitySize2D, "utilitySize");
		this.bindFieldType(Scale2D, "scale");
	}
	
	/**
	 * tools fonction to get height
	 * scale is apply
	 */
	public function getHeight() : Float
	{
		if (utilitySize == null)
			return display.skin.height; // scale already taken in this parameters
			
		return utilitySize.height * scale.scale.y;
	}
	
	/**
	 * tools fonction to get width
	 * scale is apply
	 */
	public function getWidth() : Float
	{
		if (utilitySize == null)
			return display.skin.width; // scale already taken in this parameters
			
		return utilitySize.width * scale.scale.x;
	}
	
}