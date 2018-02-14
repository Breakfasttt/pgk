package standard.module.graphic;

import core.module.Module;
import standard.components.graphic.display.impl.Layer;
import standard.group.graphic.display.GameElementGroup;

/**
 * ...
 * @author Breakyt
 */
class GameElementModule extends Module<GameElementGroup>
{
	private var m_layerModule : LayerModule;
	
	public function new(layerModuleRef : LayerModule) 
	{
		super(GameElementGroup);
		m_layerModule = layerModuleRef;
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
		if (element.gameElement.model != null && element.gameElement.skin != null && element.gameElement.skin.parent != null)
			element.gameElement.skin.parent.removeChild(element.gameElement.skin);
	}
	
	/**
	 * Sort all element and add it to stage.
	 */
	private function sortElements() : Void
	{
		var layer : Layer = null;
		m_compGroups.sort(sortGroupFunc);
		for (element in m_compGroups)
		{
			if (element.gameElement.model == null || element.gameElement.skin == null)
				continue;
			
			removeFromStage(element);
			layer = m_layerModule.getLayer(element.gameElement.entityLayerName);
			
			if (layer != null)
				layer.skin.addChild(element.gameElement.skin);
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