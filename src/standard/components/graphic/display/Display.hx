package standard.components.graphic.display;
import assets.model.Model;
import core.component.Component;
import core.entity.Entity;
import msignal.Signal.Signal0;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import tools.misc.Color;

/**
 * A Display component contains a container for assets/sprite/animation etc. and eventually Model
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
	 * The display container where the current img of model is added
	 */
	public var skin(default, null):DisplayObjectContainer;
	
	public var renderBitmap(default, null) : Bitmap;
	
	/**
	 * When True, the Location Module draw a colored Rectangle who represents the Box of this display
	 * + a red circle for the pivot
	 * Use only for debug and works only on debug configuration
	 * default = false
	 */
	public var debugDrawDisplayRect : Bool; 
	
	public function new()
	{
		super();
		this.model = null;
		this.debugDrawDisplayRect = true;
		this.skin = new Sprite();
		this.renderBitmap = new Bitmap();
		this.skin.addChild(this.renderBitmap);
	}
	
	/**
	 * Set the name of the skin with the entity name
	 */
	public function setSkinName(entity : Entity) : Void
	{
		if (this.skin == null)
			return;
		
		this.skin.name = entity.name;
	}
	
	/**
	 * Release the associed model. This function remove model from the display list too
	 */
	public function releaseModel() : Void
	{
		if (this.model != null)
		{
			if (this.renderBitmap != null)
				this.renderBitmap.bitmapData = null;
				
			this.model = null;
		}
	}	
	
	/**
	 * Set the model of this display. Release the previous model if exist
	 * @param	model
	 */
	public function setModel(model : Model) : Void
	{
		if (this.model != null)
			releaseModel();
			
		this.model = model;
	}
	
	/**
	 * enable/disable mouse on this display container.
	 * @param	enable
	 * @param	children
	 */
	public function setMouseEnable(enable : Bool, children : Bool) : Void
	{
		if (this.skin == null)
			return;
			
		this.skin.mouseEnabled = enable;
		this.skin.mouseChildren = children;
	}
	
}