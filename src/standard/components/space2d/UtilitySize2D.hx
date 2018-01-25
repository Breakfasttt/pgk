package standard.components.space2d;

import core.component.Component;

/**
 * This component force the entity to have a specific Width/Height to use
 * for location.
 * For exemple: 
 * Usefull to relocate some graphic element using this 
 * instead of inconsistent Sprite/MovieClip.Width/Height who use Mask
 * @author Breakyt
 */
class UtilitySize2D extends Component 
{
	
	public var width : Float;
	public var height : Float;

	public function new(w : Float, h : Float) 
	{
		super();
		this.width = w;
		this.height = h;
		
	}
	
}