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
	
	public function new(anchor : Anchor) 
	{
		super();
		position2d = anchor;
		if (position2d == null)	
			position2d = Anchor.topLeft;
	}
	
}