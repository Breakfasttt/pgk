package standard.components.graphic.transition.impl;
import core.entity.Entity;
import standard.components.graphic.display.Display;
import standard.components.space2d.Position2D;
import standard.components.space2d.UtilitySize2D;

/**
 * ...
 * @author Breakyt
 */
class SwapEntityTransition extends EntityTransition 
{

	private var m_speed : Float; // pixel per sec
	
	private var m_startX : Null<Float>;
	
	private var m_endX : Float;
	
	private var m_YpositionOffset : Float;
	
	private var m_YpositionOnLeftSwap : Float;
	
	private var m_left : Float;
	
	private var m_positionRef : Position2D;
	
	public function new(startX : Null<Float>,  endX : Float = 0, speed : Float = 3840.0) 
	{
		super();
		
		this.onTransition = false;
		
		m_startX = startX;
		m_endX = endX;
		m_speed = speed;
		
	}
	
	override public function setEntityRef(entityRef:Entity):Void 
	{
		super.setEntityRef(entityRef);
		
		m_positionRef = m_entityRef.getComponent(Position2D);
		
		if (m_positionRef.position2d.ratioMode)
		{
			trace("SwapEntityTransition:: WARNING : Swap transition work better with position2D.ratioMode = false. Value changed But position can be false");
			m_positionRef.position2d.ratioMode = false;
		}
		
	}
	
	override public function start():Void 
	{
		if (m_positionRef == null)
		{
			this.onTransition = false;
			this.finished.dispatch();
			return;
		}
		
		var testX : Float = 0.0;
		
		if(m_startX == null)
			testX = m_positionRef.position2d.anchor.x;
		else
		{
			testX = m_startX;
			m_positionRef.position2d.anchor.x = m_startX;
		}
		
		m_left = m_endX < testX  ? -1 : 1;
			
		this.onTransition = true;
		this.started.dispatch();
	}
	
	override public function update(dt:Float):Void 
	{
		m_positionRef.position2d.anchor.x += m_speed * dt / 1000 * m_left;
		
		if ( (m_left < 0 && m_positionRef.position2d.anchor.x <= m_endX) || 
			 (m_left > 0 && m_positionRef.position2d.anchor.x >= m_endX) )
		{
			m_positionRef.position2d.anchor.x = m_endX;
			end();
			return;
		}
	}
	
	override function end():Void 
	{
		this.onTransition = false;
		this.finished.dispatch();
	}
	
}