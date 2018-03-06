package standard.components.graphic.transition.impl;

import core.entity.Entity;
import standard.components.space2d.Scale2D;
import tools.math.Vector2D;

/**
 * Scale entity to 0/0 at scale target if entity have a Scale2D component
 * @author Breakyt
 */
class ScaleTransitionEntity extends EntityTransition 
{

	private var m_speed : Float; //Scale per second
	private var m_scaleInit : Vector2D;
	private var m_currentScale : Vector2D;
	private var m_scaleTarget : Vector2D;
	private var m_scale : Scale2D;
	
	private var m_invert : Bool;
	
	public function new(speed : Float = 1.0, scaleTargetX : Null<Float> = null, scaleTargetY : Null<Float> = null,  invert : Bool = false) 
	{
		super();
		
		m_speed = speed;
		m_invert = invert;
		
		m_currentScale = new Vector2D();
		m_scaleInit = new Vector2D(1.0,1.0);
		
		if(scaleTargetX == null || scaleTargetY == null)
			m_scaleTarget = Vector2D.clone(m_scaleInit);
		else
			m_scaleTarget = new Vector2D(scaleTargetX, scaleTargetY);
	}
	
	override public function setEntityRef(entityRef:Entity):Void 
	{
		super.setEntityRef(entityRef);
		
		if (m_entityRef == null)
			return;
		
		m_scale = m_entityRef.getComponent(Scale2D);
		if (m_scale != null)
			m_scaleInit.copy(m_scale.scale);		
	}
	
	override public function start() : Void
	{
		if (m_entityRef == null || m_scale == null)
		{
			end();
			return;
		}
		
		if (m_invert)
		{
			m_currentScale.copy(m_scaleInit);
			m_scale.scale.copy(m_currentScale);
		}
		else
		{
			m_currentScale.set(0, 0);
			m_scale.scale.copy(m_currentScale);
		}
		this.onTransition = true;
		this.started.dispatch();
	}
	
	
	override public function update(dt : Float) : Void
	{
		if (!onTransition)
			return;
		
		if (m_invert)
			invertUpdate(dt);
		else
			normalUpdate(dt);
	}
	
	override private function end() : Void
	{
		if (m_scale != null)
		{
			if (m_invert)
				m_scale.scale.set(0, 0);
			else
				m_scale.scale.copy(m_scaleTarget);
		}
		
		this.onTransition = false;
		this.finished.dispatch();
	}
	
	private function normalUpdate(dt : Float) : Void
	{
		
		m_currentScale.add(m_speed * dt / 1000, m_speed * dt / 1000); 
		if (m_currentScale.isEquals(m_scaleTarget) || (m_scaleTarget.x <= m_currentScale.x && m_scaleTarget.y <= m_currentScale.y))
		{
			end();
			return;
		}
		else
			m_scale.scale.copy(m_currentScale);
	}
	
	private function invertUpdate(dt : Float) : Void
	{
		
		m_currentScale.add( -m_speed * dt / 1000, -m_speed * dt / 1000); 
		
		if (0.0 <= m_currentScale.x && 0.0 <= m_currentScale.y)
		{
			end();
			return;
		}
		else
			m_scale.scale.copy(m_currentScale);
	}
	
}