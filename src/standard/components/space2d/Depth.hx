package standard.components.space2d;

import core.component.Component;
import msignal.Signal.Signal0;

/**
 * Represent a  Z value on a Space 2D.
 * Usefull to sort graphic element on the display list.
 * Lower value means object is the deepest
 * @author Breakyt
 */
class Depth extends Component 
{
	public var depth(default, set) : Float;
	
	public var onDepthChange : Signal0;
	
	public function new(depth : Float) 
	{
		super();
		this.onDepthChange = new Signal0();
		this.depth = depth;
	}
	
	function set_depth(value:Float):Float 
	{
		if (value != depth)
		{
			depth = value;
			this.onDepthChange.dispatch();
		}
		
		return depth;
	}
	
}