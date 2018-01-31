package input.behaviour.impl;

import input.data.PointerData;
import input.pointerImpl.BasicMouseSignals;
import input.pointerImpl.BasicPointerSignals;
import openfl.Lib;
import openfl.display.InteractiveObject;
import openfl.geom.Point;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class DragBehaviour extends PointerBehaviour 
{
	
	private var m_minX : Float;
	private var m_maxX : Float;
	private var m_minY : Float;
	private var m_maxY : Float;
	
	private var m_localStartPoint : Vector2D;
	
	public function new(object : InteractiveObject) : Void
	{
		super(null);
		
		m_localStartPoint = new Vector2D();
		
		this.m_signals = new BasicPointerSignals(object);
		this.m_signals.releaseWithRollOut = false;
		this.m_signals.press.addOnce(onStart);
	}
	
	
	public function setBoundary(minX : Float = -1, maxX : Float = -1, minY : Float = -1, maxY : Float = -1) : Void
	{
		m_minX = minX;
		m_minY = minY;
		
		if(maxX >= 0.0)
			m_maxX = maxX - m_signals.objectRef.width;
		else
			m_maxX = maxX;
			
		if(maxY >= 0.0)
			m_maxY = maxY - m_signals.objectRef.height;
		else
			m_maxY = maxY;
	}
	
	private function onStart(mousedata : PointerData)
	{
		m_localStartPoint.copy(mousedata.localPosition);
		m_worldSignals.worldPointerMove.add(onMove);
		m_worldSignals.leaveWorld.addOnce(onEnd);
		this.m_signals.release.addOnce(onEnd);
	}
	
	private function onMove(mousedata : PointerData) : Void
	{
		
		m_signals.objectRef.x = mousedata.worldPosition.x - m_localStartPoint.x; // todo manage scaling
		m_signals.objectRef.y = mousedata.worldPosition.y - m_localStartPoint.y; // todo manage scaling
		
		if (m_minX >= 0 && m_signals.objectRef.x < m_minX)
			m_signals.objectRef.x = m_minX;
		if (m_maxX >= 0 && m_signals.objectRef.x > m_maxX)
			m_signals.objectRef.x = m_maxX;
		if (m_minY >= 0 && m_signals.objectRef.y < m_minY)
			m_signals.objectRef.y = m_minY;
		if (m_maxY >= 0 && m_signals.objectRef.y > m_maxY)
			m_signals.objectRef.y = m_maxY;
	}
	
	private function onEnd(mousedata : PointerData) : Void
	{
		m_worldSignals.worldPointerMove.remove(onMove);
		m_signals.press.addOnce(onStart);
	}
	
}