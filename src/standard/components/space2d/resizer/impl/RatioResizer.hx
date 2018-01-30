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
		
		var newWidth : Float = initWidthAtScale1;
		var newHeight : Float = initHeightAtScale1;
		
		if (targetRatio < initObjRatio)
		{
			newWidth = targetWidth;
			newHeight = newWidth / initObjRatio;
		}
		else
		{
			
			newHeight = targetHeight;
			newWidth = newHeight * initObjRatio;
		}
		
		scaleResult.x = newWidth / initWidthAtScale1;
		scaleResult.y = newHeight / initHeightAtScale1;
	}
	
	override public function delete():Void 
	{
		super.delete();
	}
	
}