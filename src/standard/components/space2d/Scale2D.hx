package standard.components.space2d;

import core.component.Component;
import tools.math.Vector2D;

/**
 * A simple 2D scale component (x/y)
 * @author Breakyt
 */
class Scale2D extends Component 
{

	public var scale : Vector2D;
	
	public function new(xScale : Float = 1.0, yScale : Float = 1.0) 
	{
		super();
		
		this.scale = new Vector2D(xScale, yScale);
		
	}
	
}