package standard.group.graphic.display;

import core.component.ComponentGroup;
import standard.components.graphic.display.impl.Layer;
import standard.components.space2d.Depth;
import standard.components.space2d.UtilitySize2D;

/**
 * ...
 * @author Breakyt
 */
class LayerGroup extends ComponentGroup 
{

	public var layer : Layer;
	public var depth : Depth;
	
	public var utilitySize : UtilitySize2D;
	
	public function new() 
	{
		super();
		this.bindFieldType(Layer, "layer");
		this.bindFieldType(Depth, "depth");
		
		this.bindOptionalFieldType(UtilitySize2D, "utilitySize");
	}
	
}