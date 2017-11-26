package input.mouseBehaviour;

import input.MouseData;
import input.MouseSignals;
import openfl.Lib;
import openfl.display.InteractiveObject;
import openfl.geom.Point;

/**
 * ...
 * @author Breakyt
 */
class DragBehaviour extends MouseBehaviour 
{
	
	private var m_minX : Float;
	private var m_maxX : Float;
	private var m_minY : Float;
	private var m_maxY : Float;
	
	private var m_localStartPoint : Point;
	
	public var stageAsBoundary : Bool;
	

	public function new(object : InteractiveObject) : Void
	{
		if (object == null)
			throw "object can't be null for dragBehaviour";
		
		super("dragBehaviour", new MouseSignals(object, true, false, false, false, true));
		this.m_signals.releaseWithRollOut = false;
		this.m_signals.press.addOnce(onStart);
		stageAsBoundary = true;
	}
	
	
	public function setBoundary(minX : Float = -1, maxX : Float = -1, minY : Float = -1, maxY : Float = -1) : Void
	{
		m_minX = minX;
		m_minY = minY;
		
		if(maxX >= 0.0)
			m_maxX = maxX - m_signals.object.width;
		else
			m_maxX = maxX;
			
		if(maxY >= 0.0)
			m_maxY = maxY - m_signals.object.height;
		else
			m_maxY = maxY;
	}
	
	private function onStart(mousedata : MouseData)
	{
		m_localStartPoint = mousedata.localPosition.clone();
		this.m_signals.worldMove.add(onMove);
		this.m_signals.release.addOnce(onEnd);
		//this.m_signals.leaveWorld.addOnce(onEnd);
	}
	
	private function onMove(mousedata : MouseData) : Void
	{
		//todo better manage this
		if (stageAsBoundary)
			setBoundary(0, Lib.current.stage.stageWidth, 0, Lib.current.stage.stageHeight);
		
		m_signals.object.x = mousedata.worldPosition.x - m_localStartPoint.x; // todo manage scaling
		m_signals.object.y = mousedata.worldPosition.y - m_localStartPoint.y; // todo manage scaling
		
		if (m_minX >= 0 && m_signals.object.x < m_minX)
			m_signals.object.x = m_minX;
		if (m_maxX >= 0 && m_signals.object.x > m_maxX)
			m_signals.object.x = m_maxX;
		if (m_minY >= 0 && m_signals.object.y < m_minY)
			m_signals.object.y = m_minY;
		if (m_maxY >= 0 && m_signals.object.y > m_maxY)
			m_signals.object.y = m_maxY;
	}
	
	private function onEnd(mousedata : MouseData) : Void
	{
		this.m_signals.worldMove.remove(onMove);
		this.m_signals.press.addOnce(onStart);
	}
	
}