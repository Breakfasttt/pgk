package standard.module.graphic;

import core.Application;
import core.module.Module;
import flash.display.DisplayObjectContainer;
import flash.display.StageScaleMode;
import openfl.display.Stage;
import openfl.events.Event;
import standard.group.graphic.LocationGroup;

/**
 * Display module relocate display component with space2d component
 * @author Breakyt
 */
class LocationModule extends Module <LocationGroup>
{
	/**
	 * The stage of the application.
	 */
	private var stageRef : Stage;
	
	private var appRef : Application;
	
	public function new(stage : Stage, app  : Application) 
	{
		super(LocationGroup);
		this.appRef = app;
		this.stageRef = stage;
		this.stageRef.addEventListener(Event.RESIZE, onStageResize);
	}
	
	override function onCompGroupAdded(group:LocationGroup):Void 
	{
		group.display.skinChange.add(relocate.bind(group));
		relocate(group);
	}
	
	override function onCompGroupRemove(group:LocationGroup):Void 
	{
		group.display.skinChange.removeAll();
	}
	
	override public function update(delta:Float):Void
	{
		//relocateAll();
	}
	
	private function onStageResize(event : Event) : Void
	{
		relocateAll();
	}
	
	private function relocateAll() : Void
	{
		for (group in m_compGroups)
			relocate(group);
	}
	
	private function getParentLocation(parent : DisplayObjectContainer) : LocationGroup
	{
		if (parent == null)
			return null;
		
		for (group in m_compGroups)
		{
			if (group.display.skin == parent)
				return group;
		}
		
		return null;
	}
	
	private function relocate(group : LocationGroup) : Void
	{
		group.display.skin.scaleX = group.scale.scale.x;
		group.display.skin.scaleY = group.scale.scale.y;
		
		var parentGroup : LocationGroup = getParentLocation(group.display.skin.parent);
		var pWidth : Float = parentGroup != null ? parentGroup.getWidth() :  this.appRef.width; // todo apply scale of appRef
		var pHeight : Float = parentGroup != null ? parentGroup.getHeight() :  this.appRef.height; // todo apply scale of appRef
		
		group.position.position2d.relocate(group.display.skin, pWidth, pHeight);
		group.pivot.pivot.applyOffset(group.display.skin, group.getWidth(), group.getHeight());
	}
	
}