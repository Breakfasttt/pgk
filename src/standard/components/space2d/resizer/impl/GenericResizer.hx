package standard.components.space2d.resizer.impl;
import standard.components.space2d.resizer.Resizer;
import standard.group.graphic.location.LocationGroup;
import tools.math.Vector2D;

/**
 * Simple resizer 
 * containerW/objectW
 * containerH/objectH
 * @author Breakyt
 */
class GenericResizer extends Resizer
{

	public function new() 
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
	override public function resize(initWidthAtScale1 : Float, initHeightAtScale1 : Float, targetWidth : Float, targetHeight : Float, scaleResult : Vector2D) : Void
	{
		//var objWidthAtScale1 : Float = group.utilitySize != null : group.utilitySize.width : group.display.skin.width / group.display.skin.scaleX;
		//var objHeightAtScale1 : Float = group.utilitySize != null : group.utilitySize.height : group.display.skin.height / group.display.skin.scaleY;
		
		scaleResult.x = targetWidth / initWidthAtScale1;
		scaleResult.y = targetHeight / initHeightAtScale1;
	}
	
}