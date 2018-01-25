package standard.components.space2d;

import core.component.Component;
import tools.math.Anchor;

/**
 * Pivot2D is a component who can add a position offset for an entity
 * @author Breakyt
 */
class Pivot2D extends Component 
{
	public var pivot : Anchor;
	
	public function new(pivot : Anchor = null) 
	{
		super();
		this.pivot = pivot;
		
		if (this.pivot == null)
			this.pivot = Anchor.topLeft.clone();
	}
	
}