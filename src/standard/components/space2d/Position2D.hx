package standard.components.space2d;

import core.component.Component;
import tools.math.Anchor;
import tools.math.Vector2D;

/**
 * A composant who store a Vector2D
 * @author Breakyt
 */
class Position2D extends Component 
{

	public var position2d : Anchor; 
	
	public function new(x : Float = 0.0, y : Float = 0.0, ratioMode : Bool = false) 
	{
		super();
		position2d = new Anchor(x, y, ratioMode);
	}
	
}