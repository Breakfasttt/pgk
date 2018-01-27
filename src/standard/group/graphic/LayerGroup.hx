package standard.group.graphic;

import core.component.ComponentGroup;
import standard.components.graphic.Layer;
import standard.components.space2d.Depth;

/**
 * ...
 * @author Breakyt
 */
class LayerGroup extends ComponentGroup 
{

	public var layer : Layer;
	
	public var depth : Depth;
	
	public function new() 
	{
		super();
		this.bindFieldType(Layer, "layer");
		this.bindFieldType(Depth, "depth");
	}
	
}