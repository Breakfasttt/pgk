package standard.module.graphic;

import core.module.Module;
import flash.display.DisplayObjectContainer;
import flash.display.StageScaleMode;
import openfl.display.Stage;
import openfl.events.Event;
import standard.components.graphic.Display;
import standard.group.graphic.DisplayGroup;

/**
 * Display module sort and manage entities whith a display component on the classic display list
 * @author Breakyt
 */
class DisplayModule extends Module <DisplayGroup>
{

	/**
	 * The stage of the application.
	 * Necessary for Display component with Display.stageAsParent
	 */
	private var stage : Stage;
	
	public function new(stage : Stage, scaleMode : StageScaleMode = null) 
	{
		super(DisplayGroup);
		this.stage = stage;
		this.stage.scaleMode = scaleMode != null ? scaleMode : StageScaleMode.NO_SCALE;
		this.stage.addEventListener(Event.RESIZE, onStageResize);
	}
	
	override function onCompGroupAdded(group:DisplayGroup):Void 
	{
		group.display.onDisable.add(onDisable.bind(_, _, group));
		group.depth.onDepthChange.add(sortDisplayList);
		this.sortDisplayList();
	}
	
	override function onCompGroupRemove(group:DisplayGroup):Void 
	{
		group.display.onDisable.removeAll();
		group.depth.onDepthChange.removeAll();
		this.removeFromParent(group);
	}
	
	override public function update(delta:Float):Void 
	{
		relocateAll();
	}
	
	private function onStageResize(event : Event) : Void
	{
		relocateAll();
	}
	
	private function addToParentWithDepthSort(groups: Array<DisplayGroup>, container : DisplayObjectContainer) : Void
	{
		groups.sort(sortGroupFunc);
		for (group in groups)
		{
			removeFromParent(group);
			container.addChild(group.display.container);
		}
	}
	
	private function removeFromParent(group : DisplayGroup) : Void
	{
		if (group.display.container.parent != null)
			group.display.container.parent.removeChild(group.display.container);
	}
	
	private function sortDisplayList() : Void
	{
		var stageGroups : Array<DisplayGroup> = [];
		var tempGroup : Array<DisplayGroup> = [];
		
		for (parentGroup in m_compGroups)
		{
			if (parentGroup.display.disable)
				continue;
			
			if (parentGroup.display.parentEntityName == Display.stageAsParent)
			{
				stageGroups.push(parentGroup);
			}
			
			if (!parentGroup.display.layerMode)
				continue;
			
			tempGroup.splice(0, tempGroup.length);
			for (otherGroup in m_compGroups)
			{
				if (parentGroup == otherGroup)
					continue;
					
				if (!otherGroup.display.disable && otherGroup.display.parentEntityName == parentGroup.entityRef.name)
					tempGroup.push(otherGroup);
			}	
			addToParentWithDepthSort(tempGroup, parentGroup.display.container);
		}
		
		addToParentWithDepthSort(stageGroups, this.stage);
	}
	
	private function sortGroupFunc(group1 : DisplayGroup, group2 : DisplayGroup) : Int
	{
		if (group1.depth.depth < group2.depth.depth)
			return -1;
		else if (group1.depth.depth > group2.depth.depth)
			return 1;
		else
			return 0;
	}
	
	private function onDisable(display : Display, disable : Bool, group : DisplayGroup) : Void
	{
		if(disable)
			this.removeFromParent(group);
		else
			sortDisplayList();
	}
	
	private function relocateAll() : Void
	{
		for (group in m_compGroups)
			relocate(group);
	}
	
	private function relocate(group : DisplayGroup) : Void
	{
		group.display.container.scaleX = group.scale.scale.x;
		group.display.container.scaleY = group.scale.scale.y;
		
		var width : Float = group.utilitySize != null ? group.utilitySize.width * group.scale.scale.x : group.display.container.width;
		var height : Float = group.utilitySize != null ? group.utilitySize.height * group.scale.scale.y : group.display.container.height;
		
		if (group.pivot.pivot.ratioMode)
		{
			group.display.container.x = group.position.position2d.x - group.pivot.pivot.anchor.x * width;
			group.display.container.y = group.position.position2d.y - group.pivot.pivot.anchor.y * height;
		}
		else
		{
			group.display.container.x = group.position.position2d.x + group.pivot.pivot.anchor.x;
			group.display.container.y = group.position.position2d.y + group.pivot.pivot.anchor.y;
		}
	}
	
}