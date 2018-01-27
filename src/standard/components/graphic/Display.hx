package standard.components.graphic;
import core.component.Component;
import msignal.Signal.Signal0;
import openfl.display.DisplayObjectContainer;

/**
 * A Representation component define an assets/sprite/animation etc. for the entity
 * See Representation Module for more details
 * @author Breakyt
 */
class Display extends Component
{
	/**
	 * The container who contains all Sprite/animation, etc.
	 */
	public var skin(default,set) : DisplayObjectContainer;
	
	public function new(assetsPath : String) 
	{
		super();
	}
}