package standard.components.graphic.display;
import assets.model.Model;
import core.component.Component;
import core.entity.Entity;
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
	 * Skin.name is set to Entity.name when added to the application on LocationModule
	 * default = null;
	 */
	public var model(default, null) : Model;
	
	/**
	 * When True, the Location Module draw a colored Rectangle whoe represents the Box of this display
	 * + a blue circle for the pivot
	 * Use only for debug
	 */
	public var debugDrawDisplayRect : Bool; 
	
	public function new()
	{
		super();
		this.model = null;
	}
	
	/**
	 * Set the name of the skin with the entity name
	 */
	public function setSkinName(entity : Entity) : Void
	{
		if (this.model == null  && entity == null)
			return;
			
		if (this.model.skin == null)
			return;
		
		this.model.skin.name = entity.name;
	}
	
}