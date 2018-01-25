package standard.components.graphic;
import core.component.Component;
import openfl.display.DisplayObjectContainer;

/**
 * A display component is add and sorted to a layer component.
 * @author Breakyt
 */
class Display extends Component
{

	public assetsPath(default,null) : String;
	public display(default,null) : DisplayObjectContainer;
	
	public function new(assetsPath : String) 
	{
		super();
		
		this.assetsPath = assetsPath;
		//todo => load the display
	}
	
}