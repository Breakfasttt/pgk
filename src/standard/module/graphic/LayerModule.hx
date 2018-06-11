package standard.module.graphic;

import core.entity.Entity;
import core.module.Module;
import openfl.display.Stage;
import standard.components.graphic.display.impl.Layer;
import standard.group.graphic.display.LayerGroup;

/**
 * LayerModule add Layer to the specified stage and sort Layer component each other with there depth component
 * @author Breakyt
 */
class LayerModule extends Module<LayerGroup>
{

	/**
	 * The reference stage
	 */
	public var stageRef : Stage;
	
	public function new(stageRef : Stage) 
	{
		super(LayerGroup);
		this.stageRef = stageRef;
	}
	
	override function onCompGroupAdded(group:LayerGroup):Void 
	{
		group.layer.skin.mask = group.layer.mask;
		group.layer.skin.addChild(group.layer.mask);
		
		if (group.utilitySize != null)
		{
			group.layer.skin.mask.width = group.utilitySize.width;
			group.layer.skin.mask.height = group.utilitySize.height;
		}
		else
		{
			group.layer.skin.mask.width = group.layer.skin.width;
			group.layer.skin.mask.height = group.layer.skin.height;
			
		}
		
		sortLayers();
	}
	
	override function onCompGroupRemove(group:LayerGroup):Void 
	{
		removeFromStage(group);
	}
	
	override public function update(delta:Float):Void 
	{
		
	}
	
	/**
	 * Remove a layer from the stage
	 * @param	layer
	 */
	private function removeFromStage(layer : LayerGroup) : Void
	{
		if (layer.layer.skin.parent != null)
			layer.layer.skin.parent.removeChild(layer.layer.skin);
	}
	
	/**
	 * Sort all layer and add it to stage.
	 */
	private function sortLayers() : Void
	{
		m_compGroups.sort(sortGroupFunc);
		for (layer in m_compGroups)
		{
			removeFromStage(layer);
			this.stageRef.addChild(layer.layer.skin);
		}
	}
	
	/**
	 * Sort function with depth
	 * @param	group1
	 * @param	group2
	 * @return
	 */
	private function sortGroupFunc(group1 : LayerGroup, group2 : LayerGroup) : Int
	{
		if (group1.depth.depth < group2.depth.depth)
			return -1;
		else if (group1.depth.depth > group2.depth.depth)
			return 1;
		else
			return 0;
	}
	
	/**
	 * Get a Layer component by his name
	 * @param	layerEntityName
	 * @return
	 */
	public function getLayer(layerEntityName : String) : Layer
	{
		for (group in m_compGroups)
		{
			if (group.entityRef.name == layerEntityName)
				return group.layer;
		}
		
		return null;
	}
	
	/**
	 * Use only for special case /!\ Avoid it.
	 * @return
	 */
	public function getLayersGroup() : Array<LayerGroup>
	{
		var result : Array<LayerGroup> = [];
		
		for (group in m_compGroups)
			result.push(group);
			
		return result;
	}
}