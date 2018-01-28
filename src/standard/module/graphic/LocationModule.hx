package standard.module.graphic;

import core.Application;
import core.module.Module;
import flash.display.DisplayObjectContainer;
import flash.display.StageScaleMode;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import standard.components.space2d.Position2D;
import standard.components.space2d.resizer.Resizer;
import standard.group.graphic.location.LocationGroup;
import tools.math.Anchor;
import tools.math.Vector2D;
import tools.misc.Color;

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
	
	private var m_debugRect : Map<LocationGroup, Sprite>;
	
	private var m_appScale : Vector2D;
	
	private var m_appResizer : Resizer;
	
	public function new(stage : Stage, appResizer : Resizer) 
	{
		super(LocationGroup);
		this.stageRef = stage;
		this.m_debugRect = new Map();
		m_appScale = new Vector2D(1.0,1.0);
		m_appResizer = appResizer;
	}
	
	override function onAddedToApplication():Void 
	{
		this.stageRef.addEventListener(Event.RESIZE, onStageResize);
		onStageResize(null);
	}
	
	override function onRemoveFromApplication():Void 
	{
		this.stageRef.removeEventListener(Event.RESIZE, onStageResize);
	}
	
	override function onCompGroupAdded(group:LocationGroup):Void 
	{
		relocate(group);
	}
	
	override function onCompGroupRemove(group:LocationGroup):Void 
	{
	}
	
	override public function update(delta:Float):Void
	{
		relocateAll(); // todo improve this
	}
	
	private function onStageResize(event : Event) : Void
	{
		calculAppSize();
		resizeAll();
		relocateAll();
	}
	
	private function calculAppSize() : Void
	{
		m_appResizer.resize(m_appRef.width, m_appRef.height, stageRef.stageWidth, stageRef.stageHeight, m_appScale);
	}
	
	private function resizeAll() : Void
	{
		for (group in m_compGroups)
			resize(group);
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
	
	private function resize(group : LocationGroup) : Void
	{
		if (group.resizer == null || group.display.skin == null)
			return;
			
		if (group.display.skin.parent == this.stageRef)
			group.resizer.resize(group.getWidth(), group.getHeight(), this.stageRef.stageWidth, this.stageRef.stageHeight, group.scale.scale);
		else if(group.display.skin.parent != null)
		{
			var parentGroup : LocationGroup = getParentLocation(group.display.skin.parent);
			group.resizer.resize(group.getWidth(), group.getHeight(), parentGroup.getWidth(), parentGroup.getHeight(), group.scale.scale);
		}
	}
	
	private function relocate(group : LocationGroup) : Void
	{
		if (group.display.skin == null || group.display.skin.parent == null)
			return;
		
		group.display.skin.scaleX = group.scale.scale.x;
		group.display.skin.scaleY = group.scale.scale.y;
		
		var parentGroup : LocationGroup = getParentLocation(group.display.skin.parent);
		var pWidth : Float = parentGroup != null ? parentGroup.getWidth() : this.m_appRef.width * this.m_appScale.x;
		var pHeight : Float = parentGroup != null ? parentGroup.getHeight() : this.m_appRef.height * this.m_appScale.y;
		
		group.position.position2d.relocate(group.display.skin, pWidth, pHeight);
		
		if(group.position.pivotRelative)
			parentGroup.pivot.pivot.applyOffset(group.display.skin, pWidth, pHeight, true);
		
		group.pivot.pivot.applyOffset(group.display.skin, group.getWidth(), group.getHeight());
		
		#if debug
		{
			debugDrawDisplayRect(group);
		}
		#end
	}
	
	private function debugDrawDisplayRect(group : LocationGroup) : Void
	{
		if (group.display.skin == null)
			return;
		
		if (!group.display.debugDrawDisplayRect)
		{
			if (m_debugRect.exists(group))
			{
				group.display.skin.removeChild(m_debugRect.get(group));
				m_debugRect.remove(group);
			}
		}
		else if(!m_debugRect.exists(group))
		{
			var sprite : Sprite = new Sprite();
			
			var color : UInt = Color.randomColor();
			sprite.graphics.beginFill(color, 0.5);
			sprite.graphics.drawRect(0, 0, group.getWidth(), group.getHeight());
			sprite.graphics.endFill();
			
			var pivotPosition : Vector2D = new Vector2D();
			
			if (group.pivot.pivot.ratioMode)
			{
				pivotPosition.x =  group.getWidth() * group.pivot.pivot.anchor.x;
				pivotPosition.y =  group.getHeight() * group.pivot.pivot.anchor.y;
			}
			else
			{
				pivotPosition.x =  group.pivot.pivot.anchor.x;
				pivotPosition.y =  group.pivot.pivot.anchor.y;
			}
			
			sprite.graphics.beginFill(Color.red, 0.5);
			sprite.graphics.drawCircle(pivotPosition.x, pivotPosition.y, 3.0);
			sprite.graphics.endFill();
			
			group.display.skin.addChildAt(sprite,group.display.skin.numChildren);
			m_debugRect.set(group, sprite);
		}
	}
	
	public function debugDrawAllDisplayRect() : Void
	{
		for (group in m_compGroups)
		{
			group.display.debugDrawDisplayRect = !group.display.debugDrawDisplayRect;
		}
	}
	
}