package standard.module.graphic;

import core.Application;
import core.entity.Entity;
import core.module.Module;
import flash.display.DisplayObjectContainer;
import flash.display.StageScaleMode;
import openfl.Lib;
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
	private var m_stageRef : Stage;
	
	/**
	 * A map of Location representation Usefull only for debug
	 */
	private var m_debugRect : Map<LocationGroup, Sprite>;	
	
	/**
	 * Display module relocate display component with space2d component
	 * @param	stage : The reference stage (in general Lib.current.stage)
	 */
	public function new(stage : Stage) 
	{
		super(LocationGroup);
		this.m_stageRef = stage;
		this.m_debugRect = new Map();
	}
	
	override function onAddedToApplication():Void 
	{
		this.m_stageRef.addEventListener(Event.RESIZE, onStageResize);
		onStageResize(null);
	}
	
	override function onRemoveFromApplication():Void 
	{
		this.m_stageRef.removeEventListener(Event.RESIZE, onStageResize);
	}
	
	override function onCompGroupAdded(group:LocationGroup):Void 
	{
		group.display.setSkinName(group.entityRef);
		relocate(group);
	}
	
	override function onCompGroupRemove(group:LocationGroup):Void 
	{
	}
	
	override public function update(delta:Float):Void
	{
		relocateAll(); // todo improve this
	}

	/**
	 * Function call when a stage Resize is detected
	 * @param	event
	 */
	private function onStageResize(event : Event) : Void
	{
		resizeAll();
		relocateAll();
	}
	
	/**
	 * Resize all group
	 */
	private function resizeAll() : Void
	{
		for (group in m_compGroups)
			resize(group);
	}
	
	/**
	 * Replace all element in a 2d space
	 */
	private function relocateAll() : Void
	{
		for (group in m_compGroups)
			relocate(group);
	}
	
	/**
	 * Get a location group by his entity. (if exist, else return null
	 * @param	e
	 * @return
	 */
	public function getEntityLocation(e : Entity) : LocationGroup
	{
		if (e == null)
			return null;
			
		for (group in m_compGroups)
		{
			if (group.entityRef == e)
			{
				return group;
			}
		}
		
		return null;
	}
	
	/**
	 * Get the LocationGroup  of the specified displayObjectContainer (if exist, else return null)
	 * @param	parent
	 * @return
	 */
	public function getLocation(skin : DisplayObjectContainer) : LocationGroup
	{
		if (skin == null)
			return null;
		
		for (group in m_compGroups)
		{
			if (group.display.skin == skin)
				return group;
		}
		
		return null;
	}
	
	/**
	 * Resize group by setting is scale2d component using his Resizer if exist
	 * @param	group
	 */
	private function resize(group : LocationGroup) : Void
	{
		if (group.resizer == null || group.display.skin == null)
			return;
		
		//trace("Resize with window : " + Lib.application.window.width + "/" + Lib.application.window.height);
		//trace("Resize with stage : " + this.m_stageRef.stageWidth + "/" + this.m_stageRef.stageHeight);
			
		if (group.display.skin.parent == this.m_stageRef)
			group.resizer.resize(group.getWidthAtScale1(), group.getHeightAtScale1(), this.m_stageRef.stageWidth, this.m_stageRef.stageHeight, group.scale.scale);
		else if(group.display.skin.parent != null)
		{
			var parentGroup : LocationGroup = getLocation(group.display.skin.parent);
			group.resizer.resize(group.getWidthAtScale1(), group.getHeightAtScale1(), parentGroup.getWidth(), parentGroup.getHeight(), group.scale.scale);
		}
	}
	
	/**
	 * Relocate the display.skin of the group using scale, size and position
	 * @param	group
	 */
	private function relocate(group : LocationGroup) : Void
	{
		if (group.display.skin == null || group.display.skin.parent == null)
			return;
		
		group.display.skin.scaleX = group.scale.scale.x;
		group.display.skin.scaleY = group.scale.scale.y;
		
		var pWidth : Float =  0.0; 
		var pHeight : Float = 0.0; 
		var parentGroup : LocationGroup = getLocation(group.display.skin.parent);
		
		if (parentGroup != null)
		{
			pWidth = parentGroup.getWidth();
			pHeight = parentGroup.getHeight();
		}
		else if (group.display.skin.parent == this.m_stageRef)
		{
			pWidth = this.m_stageRef.stageWidth;
			pHeight = this.m_stageRef.stageHeight;
		}
		else
		{
			pWidth = m_appRef.width;
			pHeight = m_appRef.height;
		}
		
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
	
	/**
	 * Create, draw and add to display list an alpha square who represent The LocationGroup (using space2d component)
	 * @param	group
	 */
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
			sprite.mouseEnabled = false;
			sprite.mouseChildren = false;
			
			group.display.skin.addChildAt(sprite,group.display.skin.numChildren);
			m_debugRect.set(group, sprite);
		}
	}
	
	public function forceResize() : Void
	{
		onStageResize(null);
	}
	
	/**
	 * On debug : Show all debug LocationGroup's rectangle on the displayList if not already active.
	 * If active, Hide all debug LocationGroup's rectangle.
	 */
	public function debugShowLocGroupRect() : Void
	{
		for (group in m_compGroups)
		{
			group.display.debugDrawDisplayRect = !group.display.debugDrawDisplayRect;
		}
	}
	
}