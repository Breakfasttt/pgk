package input.behaviour.impl;

import input.data.PointerData;
import input.pointerImpl.BasicMouseSignals;
import input.pointerImpl.BasicPointerSignals;
import openfl.Lib;
import openfl.display.InteractiveObject;
import openfl.geom.Point;
import tools.math.Vector2D;

/**
 * Drag'n'drop a Vector2D. Not directly a DisplayObject. 
 * The object in parameters is here only to listen mouse signal.
 * @author Breakyt
 */
class DragBehaviour extends PointerBehaviour 
{
	
	private var m_minX : Float;
	private var m_maxX : Float;
	private var m_minY : Float;
	private var m_maxY : Float;
	
	private var m_localStartPoint : Vector2D;
	
	public var lastCoord(default,null) : Vector2D; 
	
	public var startCb : Vector2D->Void;
	public var moveCb : Vector2D->Void;
	public var endCb : Vector2D->Void;
	
	public function new(object : InteractiveObject) : Void
	{
		super(null);
		
		m_localStartPoint = new Vector2D();
		lastCoord = new Vector2D(object.x, object.y);
		
		this.m_signals = new BasicPointerSignals(object);
		this.m_signals.releaseWithRollOut = false;
		this.m_signals.press.addOnce(onStart);
		
		this.startCb = null;
		this.moveCb = null;
		this.endCb = null;
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
		try
		{
			m_localStartPoint.copy(mousedata.localPosition);
			m_worldSignals.worldPointerMove.add(onMove);
			
			this.m_signals.release.addOnce(onEnd);
			m_worldSignals.leaveWorld.addOnce(onEnd);
			m_worldSignals.worldPointerRelease.add(isPointerReleasedOutBound);
			
			this.lastCoord.copy(m_localStartPoint);
			if (this.startCb != null)
				this.startCb(this.lastCoord);
		}
		catch (e : Dynamic)
		{
			trace("onStart :"  + e);
		}
	}
	
	private function onMove(mousedata : PointerData) : Void
	{
		try
		{
			lastCoord.x =  mousedata.worldPosition.x - m_localStartPoint.x;
			lastCoord.y =  mousedata.worldPosition.y - m_localStartPoint.y;
			
			if (m_minX >= 0 && lastCoord.x < m_minX)
				lastCoord.x = m_minX;
			if (m_maxX >= 0 && lastCoord.x > m_maxX)
				lastCoord.x = m_maxX;
			if (m_minY >= 0 && lastCoord.y < m_minY)
				lastCoord.y = m_minY;
			if (m_maxY >= 0 && lastCoord.y > m_maxY)
				lastCoord.y = m_maxY;
				
			if (this.moveCb != null)
				this.moveCb(this.lastCoord);
		}
		catch (e : Dynamic)
		{
			trace("onMove :"  + e);
		}
	}
	
	private function isPointerReleasedOutBound(pointerData : PointerData) : Void
	{
		if (m_minX >= 0 && pointerData.worldPosition.x < m_minX)
			onEnd(pointerData);
		if (m_maxX >= 0 && pointerData.worldPosition.x > m_maxX)
			onEnd(pointerData);
		if (m_minY >= 0 && pointerData.worldPosition.y < m_minY)
			onEnd(pointerData);
		if (m_maxY >= 0 && pointerData.worldPosition.y > m_maxY)
			onEnd(pointerData);
	}
	
	private function onEnd(mousedata : PointerData) : Void
	{
		try
		{
			m_worldSignals.worldPointerMove.remove(onMove);
			m_worldSignals.worldPointerRelease.remove(isPointerReleasedOutBound);
			m_signals.press.addOnce(onStart);	
			
			lastCoord.x =  mousedata.worldPosition.x - m_localStartPoint.x;
			lastCoord.y =  mousedata.worldPosition.y - m_localStartPoint.y;		
			
			if (this.endCb != null)
				this.endCb(this.lastCoord);
			}
		catch (e : Dynamic)
		{
			trace("onEnd :"  + e);
		}
	}
	
}