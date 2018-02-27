package standard.components.space2d;

import core.component.Component;
import openfl.display.DisplayObject;

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
	
	public var autoUtilitySize : Bool;

	/**
	 * This component force the entity to have a specific Width/Height to use
	 * for location.
	 * @param	w : width
	 * @param	h : height
	 * @param	autoUtilitySize : if true, on the location module resize the utility size depending of the display.skin at scale X/Y 1.0 rotation 0.0
	 *  can be usefull for composition with GameElementDisplay for exemple.
	 */
	public function new(w : Float, h : Float, autoUtilitySize : Bool = false) 
	{
		super();
		this.width = w;
		this.height = h;
		this.autoUtilitySize = autoUtilitySize;
	}
	
	/**
	 * Set the utility size using 
	 * @param	skin
	 */
	public function setUtilitySizeBySkin(skin : DisplayObject)
	{
		var tempRotation = skin.rotation;
		var tempScaleX = skin.scaleX;
		var tempScaleY = skin.scaleY;
		skin.rotation = 0.0;
		skin.scaleX = 1.0;
		skin.scaleY = 1.0;
		
		this.width = skin.width;
		this.height = skin.height;
		
		skin.scaleX = tempScaleX;
		skin.scaleY = tempScaleY;
		skin.rotation = tempRotation;
	}
	
}