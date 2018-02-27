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
	 * A tools variable to rotate pivot whitout erase group value
	 */
	private var m_rotatedPivot : Anchor;
	
	/**
	 * Display module relocate display component with space2d component
	 * @param	stage : The reference stage (in general Lib.current.stage)
	 */
	public function new(stage : Stage) 
	{
		super(LocationGroup);
		this.m_stageRef = stage;
		this.m_debugRect = new Map();
		m_rotatedPivot = new Anchor(0, 0);
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
		if (group.resizer == null )
			return;
			
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
		if (group.display.skin.parent == null)
			return;
			
		#if debug
		
			//debug display is remove to dont impact resize.
			if (m_debugRect.exists(group))
				group.display.skin.removeChild(m_debugRect.get(group));
		
		#end
			
		group.display.skin.rotation = 0;	
		group.display.skin.scaleX = 1.0;
		group.display.skin.scaleY = 1.0;
		
		if (group.utilitySize != null && group.utilitySize.autoUtilitySize)
			group.utilitySize.setUtilitySizeBySkin(group.display.skin);
		
		group.display.skin.scaleX = group.scale.scale.x;
		group.display.skin.scaleY = group.scale.scale.y;
		
		
		var initWidth  : Float = group.getWidth(); // width with scale at rotation 0
		var initHeight  : Float = group.getHeight(); // height with scale at rotation 0
		
		var pWidth : Float =  0.0; 
		var pHeight : Float = 0.0; 
		var parentGroup : LocationGroup = getLocation(group.display.skin.parent);
		
		if (parentGroup != null)
		{
			pWidth = parentGroup.getWidthAtScale1();
			pHeight = parentGroup.getHeightAtScale1();
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
			
		if (group.rotation != null)
			group.display.skin.rotation = group.rotation.angle;			
			
		group.pivot.pivot.applyOffset(group.display.skin, initWidth, initHeight);
			
		
		
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
			var rect : Sprite = new Sprite();
			var pivot : Sprite = new Sprite();
			var color : UInt = Color.randomColor();
			
			rect.graphics.beginFill(color, 0.5);
			rect.graphics.drawRect(0, 0, group.getWidth(), group.getHeight());
			rect.graphics.endFill();
			
			var pivotPosition : Vector2D = new Vector2D();
			
			if (group.pivot.pivot.ratioMode)
			{
				pivotPosition.x =  group.getWidthAtScale1() * group.pivot.pivot.anchor.x;
				pivotPosition.y =  group.getHeightAtScale1() * group.pivot.pivot.anchor.y;
			}
			else
			{
				pivotPosition.x =  group.pivot.pivot.anchor.x;
				pivotPosition.y =  group.pivot.pivot.anchor.y;
			}
			
			pivot.graphics.beginFill(Color.red, 0.5);
			pivot.graphics.drawCircle(0.0, 0.0, 3.0);
			pivot.graphics.endFill();
			pivot.x = pivotPosition.x;
			pivot.y = pivotPosition.y;
			
			sprite.addChild(rect);
			sprite.addChild(pivot);
			
			sprite.mouseEnabled = false;
			sprite.mouseChildren = false;
			
			group.display.skin.addChildAt(sprite,group.display.skin.numChildren);
			m_debugRect.set(group, sprite);
		}
		else
		{
			var sprite : Sprite = m_debugRect.get(group);
			
			var pivotPosition : Vector2D = new Vector2D();
			if (group.pivot.pivot.ratioMode)
			{
				pivotPosition.x =  group.getWidthAtScale1() * group.pivot.pivot.anchor.x;
				pivotPosition.y =  group.getHeightAtScale1() * group.pivot.pivot.anchor.y;
			}
			else
			{
				pivotPosition.x =  group.pivot.pivot.anchor.x;
				pivotPosition.y =  group.pivot.pivot.anchor.y;
			}
			
			sprite.getChildAt(1).x = pivotPosition.x;
			sprite.getChildAt(1).y = pivotPosition.y;
			
			group.display.skin.addChildAt(sprite,group.display.skin.numChildren);
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