package standard.components.graphic;
import core.component.Component;
import msignal.Signal.Signal0;
import openfl.display.DisplayObjectContainer;

/**
 * A Representation component define an assets/sprite/animation etc. for the entity
 * See Representation Module for more details
 * @author Breakyt
 */
class Representation extends Component
{

	/**
	 * The path of the representation assets 
	 */
	public var assetsPath(default, set) : String;
	
	/**
	 * Signal dispatch when assets path change
	 */
	public var pathChange : Signal0 ;
	
	public function new(assetsPath : String) 
	{
		super();
		
		this.pathChange = new Signal0();
		this.assetsPath = assetsPath;
		
	}
	
	function set_assetsPath(value:String):String 
	{
		assetsPath = value;
		this.pathChange.dispatch();
		return assetsPath;
	}
	
}