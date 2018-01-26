package standard.components.space2d;

import core.component.Component;
import tools.math.Vector2D;

/**
 * A composant who store a Vector2D
 * @author Breakyt
 */
class Position2D extends Component 
{

	public var position2d : Vector2D; //todo => swap to anchor ?
	
	public function new(x : Float = 0.0, y : Float = 0.0) 
	{
		super();
		position2d = new Vector2D(x, y);
	}
	
}