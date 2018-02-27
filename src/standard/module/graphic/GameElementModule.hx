package standard.module.graphic;

import core.entity.Entity;
import core.module.Module;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.Layer;
import standard.group.graphic.display.GameElementGroup;

/**
 * ...
 * @author Breakyt
 */
class GameElementModule extends Module<GameElementGroup>
{

	/**
	 * tools variable
	 */
	var m_tempParentEntity : Entity;
	
	public function new() 
	{
		super(GameElementGroup);
		m_tempParentEntity = null;
	}
	
	override function onCompGroupAdded(group:GameElementGroup):Void 
	{
		sortElements();
	}
	
	override function onCompGroupRemove(group:GameElementGroup):Void 
	{
		removeFromStage(group);
	}
	
	override public function update(delta:Float):Void 
	{
		
	}
	
	
	/**
	 * Remove an element from his layer
	 * @param	element
	 */
	private function removeFromStage(element : GameElementGroup) : Void
	{
		if (element.gameElement.skin != null && element.gameElement.skin.parent != null)
			element.gameElement.skin.parent.removeChild(element.gameElement.skin);
	}
	
	/**
	 * Sort all element and add it to stage.
	 */
	private function sortElements() : Void
	{
		m_compGroups.sort(sortGroupFunc);
		for (element in m_compGroups)
		{
			if (element.gameElement.skin == null)
				continue;
			
			removeFromStage(element);
			m_tempParentEntity = this.m_appRef.getEntity(element.gameElement.entityParentName);
			
			if (m_tempParentEntity != null)
			{
				var display : Display = m_tempParentEntity.getComponent(Display);
				
				if(display != null && display.skin != null) 
					display.skin.addChild(element.gameElement.skin);
			}
		}
	}	
	
	/**
	 * Sort function with depth
	 * @param	group1
	 * @param	group2
	 * @return
	 */
	private function sortGroupFunc(group1 : GameElementGroup, group2 : GameElementGroup) : Int
	{
		if (group1.depth.depth < group2.depth.depth)
			return -1;
		else if (group1.depth.depth > group2.depth.depth)
			return 1;
		else
			return 0;
	}
	
}