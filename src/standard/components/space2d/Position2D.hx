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

	/**
	 * The 2D position
	 */
	public var position2d : Anchor; 
	
	
	/**
	 * If relative = true, This position is relative to the parent pivot  => "position + pivot + ParentPosition + Parentpivot"
	 * If false, This position relative to the topLeft corner of the parent => "position + pivot + ParentPosition"
	 * If no parent detected, position is relative to the stage(0,0) position regardless of this boolean
	 * Default = false;
	 */
	public var pivotRelative : Bool;
	
	public function new(anchor : Anchor) 
	{
		super();
		pivotRelative = false;
		position2d = anchor;
		if (position2d == null)	
			position2d = Anchor.topLeft;
	}
	
}