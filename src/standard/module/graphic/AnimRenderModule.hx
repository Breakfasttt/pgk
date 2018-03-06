package standard.module.graphic;

import core.module.Module;
import openfl.display.Bitmap;
import standard.components.space2d.Pivot2D;
import standard.group.graphic.render.AnimRenderGroup;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class AnimRenderModule extends Module<AnimRenderGroup>
{

	private var m_vectorForAnimationOffset : Vector2D;
	
	public function new() 
	{
		super(AnimRenderGroup);
		m_vectorForAnimationOffset = new Vector2D();
	}
	
	
	override function onCompGroupAdded(group:AnimRenderGroup):Void 
	{
		
	}
	
	override function onCompGroupRemove(group:AnimRenderGroup):Void 
	{
		
	}
	
	override function onAddedToApplication():Void 
	{
		
	}
	
	override function onRemoveFromApplication():Void 
	{
		
	}
	
	override public function update(delta:Float):Void 
	{
		for (group in m_compGroups)
		{
			if (group.display.model == null)
				continue;
			
			if (group.animation == null && group.display.renderBitmap.bitmapData == null)
			{
				group.display.renderBitmap.bitmapData = group.display.model.getFirstFrame();
			}
			else if (group.animation != null)
			{
				group.animation.update(delta);
				group.display.renderBitmap.bitmapData = group.display.model.getBitmapData(group.animation.currentFrame, group.animation.currentAnim);
				group.pivot.pivot.ratioMode = false;
				group.pivot.pivot.anchor.copy(group.display.model.getBitmapDataOffset(group.animation.currentFrame, group.animation.currentAnim));
			}
		}
		
	}
	
	
}