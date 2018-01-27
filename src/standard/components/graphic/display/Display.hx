package standard.components.graphic.display;
import core.component.Component;
import msignal.Signal.Signal0;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import tools.misc.Color;

/**
 * A Display component define a container for assets/sprite/animation etc. 
 * This class need to be override.
 * @author Breakyt
 */
class Display extends Component
{
	/**
	 * The container who contains all Sprite/animation, etc.
	 * default = null;
	 */
	public var skin(default, null) : DisplayObjectContainer;
	
	/**
	 * When True, the Location Module draw a colored Rectangle whoe represents the Box of this display
	 * + a blue circle for the pivot
	 * Use only for debug
	 */
	public var debugDrawDisplayRect : Bool; 
	
	public function new()
	{
		super();
		this.skin = null;
	}
	
	/**
	 * Usefull function to create a square when a Display doesn't exist or can't be created.
	 * @return Sprite
	 */
	private function createSquare(w : Float = 50.0, h : Float = 50, color : Null<UInt> = null) : Sprite
	{
		if (color == null)
			color = Color.randomColor();
		
		var result : Sprite = new Sprite();
		result.graphics.beginFill(color);
		result.graphics.drawRect(0, 0, w, h);
		result.graphics.endFill();
		return result;
	}	
	
}