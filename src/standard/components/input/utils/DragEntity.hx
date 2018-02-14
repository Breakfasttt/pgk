package standard.components.input.utils;
import core.Application;
import core.entity.Entity;
import input.behaviour.impl.DragBehaviour;
import input.data.PointerData;
import openfl.Lib;
import standard.components.graphic.display.Display;
import standard.components.space2d.Position2D;
import standard.components.space2d.Scale2D;
import standard.components.space2d.UtilitySize2D;
import standard.group.graphic.location.LocationGroup;
import standard.module.graphic.LocationModule;
import tools.math.Vector2D;

/**
 * A Pointer Behaviour component to drag'n'drop an entity
 * @author Breakyt
 */
class DragEntity extends EntityPointerBehaviour 
{

	private var m_locModule : LocationModule;
	
	private var m_locationRef : LocationGroup;
	private var m_parentLocationRef : LocationGroup;
	
	private var m_startPosition : Vector2D;
	
	private var m_parentPosition : Vector2D;
	private var m_parentScale : Vector2D;
	private var m_parentWidth : Vector2D;
	
	private var m_minPosition : Vector2D;
	private var m_maxPosition : Vector2D;
	
	public function new(locModuleRef : LocationModule) 
	{
		super();
		m_locModule = locModuleRef;
		m_locationRef = null;
		m_parentLocationRef = null;
	}
	
	override public function setEntityRef(entityRef:Entity):Void 
	{
		super.setEntityRef(entityRef);
		
		if (m_entityRef == null)
			return;
			
		if (m_locModule == null)
			return;
			
		m_locationRef = m_locModule.getEntityLocation(m_entityRef);
			
		if (m_locationRef == null)
			return;
			
		if (m_locationRef.display.model == null)
			return;
			
		if (m_locationRef.display.model.skin == null)
			return;
			
		m_startPosition = new Vector2D();
		m_parentPosition = new Vector2D();
		m_parentScale = new Vector2D();
		m_parentWidth = new Vector2D();
		m_minPosition = new Vector2D();
		m_maxPosition = new Vector2D();
			
		m_parentLocationRef = m_locModule.getLocation(m_locationRef.display.model.skin.parent);
			
		m_locationRef.position.position2d.ratioMode = false;
			
		m_pointerBehaviour = new DragBehaviour(m_locationRef.display.model.skin);
		
		cast(m_pointerBehaviour, DragBehaviour).startCb = onDragStart;
		cast(m_pointerBehaviour, DragBehaviour).moveCb = onEntityMove;
		cast(m_pointerBehaviour, DragBehaviour).endCb = onDragStop;
	}
	
	private function getParentData() : Void
	{
		if (m_parentLocationRef == null)
		{
			m_parentPosition.set(0, 0);
			m_parentScale.set(1.0, 1.0);
			m_parentWidth.set(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight); // todo improve this
		}
		else
		{
			if (m_parentLocationRef.position.position2d.ratioMode)
				m_parentPosition.set(m_parentLocationRef.display.model.skin.x, m_parentLocationRef.display.model.skin.y); //improve this
			else
				m_parentPosition.copy(m_parentLocationRef.position.position2d.anchor);
				
			m_parentScale.copy(m_parentLocationRef.scale.scale);
			m_parentWidth.set(m_parentLocationRef.getWidthAtScale1(), m_parentLocationRef.getHeightAtScale1());
		}
		
		m_minPosition.set(0, 0);
		m_maxPosition.copy(m_parentWidth);
		m_maxPosition.x -= m_locationRef.getWidthAtScale1();
		m_maxPosition.y -= m_locationRef.getHeightAtScale1();
	}
	
	private function onDragStart(pos : PointerData) : Void
	{
		m_startPosition.copy(pos.localPosition);
	}
	
	private function onEntityMove(pos : PointerData) : Void
	{
		//m_position2DRef.position2d.anchor.copy(pos);
		getParentData();
		m_locationRef.position.position2d.anchor.copy(pos.worldPosition).substract(m_parentPosition).divide(m_parentScale).substract(m_startPosition);
		m_locationRef.position.position2d.anchor.xLimits(m_minPosition.x, m_maxPosition.x);
		m_locationRef.position.position2d.anchor.yLimits(m_minPosition.y, m_maxPosition.y);
	}
	
	private function onDragStop(pos : PointerData) : Void
	{
	}
	
	override public function delete():Void 
	{
		super.delete();
		m_locationRef = null;
		m_parentLocationRef = null;
	}
	
}