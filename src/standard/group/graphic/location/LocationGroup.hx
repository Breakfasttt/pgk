package standard.group.graphic.location;

import core.component.ComponentGroup;
import standard.components.graphic.display.Display;
import standard.components.space2d.Depth;
import standard.components.space2d.Pivot2D;
import standard.components.space2d.Position2D;
import standard.components.space2d.Rotation2D;
import standard.components.space2d.Scale2D;
import standard.components.space2d.UtilitySize2D;
import standard.components.space2d.resizer.Resizer;

/**
 * A group managed by DisplayModule. See it for more details
 * @author Breakyt
 */
class LocationGroup extends ComponentGroup 
{
	public var display : Display;
	public var position : Position2D;
	public var pivot : Pivot2D;
	public var scale : Scale2D;
	
	public var rotation : Rotation2D;
	
	public var utilitySize : UtilitySize2D;
	public var resizer : Resizer;
	
	private var m_tempRotation : Float;
	private var m_tempResult : Float;
	
	public function new() 
	{
		super();
		this.bindFieldType(Display, "display");
		this.bindFieldType(Position2D, "position");
		this.bindFieldType(Pivot2D, "pivot");
		this.bindFieldType(Scale2D, "scale");
		
		this.bindOptionalFieldType(Rotation2D, "rotation");
		this.bindOptionalFieldType(UtilitySize2D, "utilitySize");
		this.bindOptionalFieldType(Resizer, "resizer");
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
	 * tools fonction to get width include scale and rotation
	 * scale is apply
	 */
	public function getWidth() : Float
	{
		if (utilitySize == null)
			return display.skin.width; // scale already taken in this parameters
			
		return utilitySize.width * scale.scale.x;
	}
		
	/**
	 * tools fonction to get width at scale 1.0
	 * scale is not apply
	 */
	public function getWidthAtScale1() : Float
	{
		if (utilitySize == null)
			return display.skin.width / display.skin.scaleX; 
			
		return utilitySize.width;
	}	
	

	/**
	 * tools fonction to get height at scale 1.0
	 * scale is not apply
	 */
	public function getHeightAtScale1() : Float
	{
		if (utilitySize == null)
			return display.skin.height / display.skin.scaleY; 
			
		return utilitySize.height;
	}
}