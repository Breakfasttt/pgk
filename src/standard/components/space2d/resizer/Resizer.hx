package standard.components.space2d.resizer;
import core.component.Component;
import standard.group.graphic.location.LocationGroup;
import tools.math.Vector2D;

/**
 * Base class for Resizer component.
 * Extend this class for specific resizer.
 * @author Breakyt
 */
class Resizer extends Component
{
	
	public function new() : Void
	{
		super();
	}
	
	/**
	 * @param	initWidthAtScale1 : width of the object at scale 1.0
	 * @param	initHeightAtScale1 : height of the object at scale 1.0
	 * @param	targetWidth : Container Width or Target Width (like a specific ratio 1920 * 1080)
	 * @param	targetHeight : Container Width or Target Width (like a specific ratio 1920 * 1080)
	 * @param	scaleResult : The vector2D where the result is setted. (This function must modify 'scaleResult')
	 */
	public function resize(initWidthAtScale1 : Float, initHeightAtScale1 : Float, targetWidth : Float, targetHeight : Float, scaleResult : Vector2D ) : Void
	{
		
	}
	
	
}