package standard.components.graphic;

import core.component.Component;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;

/**
 * A Display component is a DisplayObjectContainer added to the specified Parent Entity
 * You can specifie that the parent is the Stage using "Display.parentIsStage"
 * @author Breakyt
 */
class Display extends Component 
{
	/**
	 * Word key to add the container to the stage.
	 * Usefull to crate layer.
	 */
	public static var parentIsStage : String = "Display::parentIsStage::Display";
	
	/**
	 * The container added to the display list
	 */
	public var container : DisplayObjectContainer;
	
	/**
	 * The name of the parent Entity you want to attach this display.
	 * Default "Display.parentIsStage"
	 */
	public var parentEntityName : String;
	
	/**
	 * You can enable/disable this display. A Display disable means the containers is remove
	 * from the DisplayList.
	 * default = false
	 */
	public var disable(default, set) : Bool;
	
	
	/**
	 * Signal dispatch when disable set to true/false
	 * dispatch with 'this' and 'true/false'
	 */
	public var onDisable : Signal2<Display, Bool>;
	
	/**
	 * Set this display to be considerate as layer.
	 * A layer is used as a parent container for other display.
	 * An Entity with a display set as layer can't have a Representation.
	 * A Display Composant set as NOT a layer can't have children (except his Representation Component, see RepresentationModule)
	 */
	public var layerMode : Bool;
	
	/**
	 * A Display component is a DisplayObjectContainer added to the specified Parent Entity
	 * You can specifie that the parent is the Stage using "Display.parentIsStage" (default)
	 * @param parentEntityName : The parent entity name, default : Display.parentIsStage
	 * @param layerMode : 	Set this display to be considerate as layer, A layer is used as a parent container for other display. 
	 * 						An Entity with a display set as layer can't have a Representation.
	 * 						A Display Composant set as NOT a layer can't have children (except his Representation Component, see RepresentationModule)
	 * @param disable false means the container is not add / is remove from the displayList
	 * @param containerType, if you want a specific container type (sprite, movieclip, other ?) default => sprite
	 */	
	public function new(parentEntityName : String = null, layerMode : Bool = false, disable : Bool = false, containerType : DisplayObjectContainer = null) 
	{
		super();
		
		this.container = containerType;
		
		if (this.container == null)
			this.container = new Sprite();
		
		this.parentEntityName = parentEntityName != null ? parentEntityName : Display.parentIsStage;
		
		this.layerMode = layerMode;
		
		this.onDisable = new Signal2<Display, Bool>();
		
		this.disable = disable;
	}
	
	private function set_disable(value:Bool):Bool 
	{
		disable = value;
		this.onDisable.dispatch(this, disable);
		return disable;
	}
	
}