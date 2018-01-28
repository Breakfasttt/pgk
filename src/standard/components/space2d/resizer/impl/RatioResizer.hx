package standard.components.space2d.resizer.impl;

import standard.components.space2d.resizer.Resizer;
import standard.group.graphic.location.LocationGroup;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class RatioResizer extends Resizer 
{

	public function new() 
	{
		super();
	}
	
	override public function resize(initWidthAtScale1 : Float, initHeightAtScale1 : Float, targetWidth : Float, targetHeight : Float, scaleResult : Vector2D ) : Void
	{
		var targetRatio : Float = targetWidth / targetHeight;
		var initObjRatio : Float = initWidthAtScale1 / initHeightAtScale1;
		
		var newScaleX : Float = 1.0;
		var newScaleY : Float = 1.0;
		
		if (targetRatio < initObjRatio)
		{
			newScaleX = targetWidth / initWidthAtScale1;
			newScaleY = newScaleX / initObjRatio;
		}
		else
		{
			
			newScaleY = targetHeight / initHeightAtScale1;
			newScaleX = newScaleY * initObjRatio;
		}
		
		scaleResult.x = newScaleX;
		scaleResult.y = newScaleY;
	}
	
	override public function delete():Void 
	{
		super.delete();
	}
	
}