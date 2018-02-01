package input.behaviour.impl;

import input.data.PointerData;
import input.pointerImpl.BasicMouseSignals;
import input.pointerImpl.BasicPointerSignals;
import openfl.Lib;
import openfl.display.InteractiveObject;
import openfl.display.Stage;
import openfl.geom.Point;
import tools.math.Vector2D;

/**
 * Drag'n'drop a Vector2D. Not directly a DisplayObject. 
 * The object in parameters is here only to listen mouse signal.
 * @author Breakyt
 */
class DragBehaviour extends PointerBehaviour 
{
	
	/**
	 * World Rectangle for bounds
	 * default : Object parent's x/y/w/h set this bounds
	 */
	private var m_minX : Float;
	private var m_maxX : Float;
	private var m_minY : Float;
	private var m_maxY : Float;
	
	/**
	 * the target object
	 */
	private var m_targetObject : InteractiveObject;
	
	/**
	 * var save to get the pointer id who start the drag
	 */
	private var m_actualPointerId : Int;
	
	/**
	 * The local Object Start Point
	 */
	private var m_localStartPoint : Vector2D;
	
	/**
	 * The objectParentPosition
	 */
	private var m_parentPosition : Vector2D;
	
	/**
	 * The objectParentPosition
	 */
	private var m_parentScale : Vector2D;
	
	/**
	 * Last World coordonate calculated
	 */
	public var lastCoord(default,null) : Vector2D; 
	
	/**
	 * Callback when drag start with Last local coordonate in parameters
	 */
	public var startCb : Vector2D->Void;
	
	/**
	 * Callback when drag move with Last local coordonate in parameters
	 */
	public var moveCb : Vector2D->Void;
	
	/**
	 * Callback when end start with Last local coordonate in parameters
	 */
	public var endCb : Vector2D->Void;
	
	/**
	 * Create a simple Drag behaviour 
	 * @param	object : The object where pointer callback 
	 */
	public function new(object : InteractiveObject) : Void
	{
		super(null);
		
		m_targetObject = object;
		m_actualPointerId = -1;
		m_localStartPoint = new Vector2D();
		lastCoord = new Vector2D(object.x, object.y);
		m_parentPosition = new Vector2D();
		m_parentScale = new Vector2D();
		
		this.m_signals = new BasicPointerSignals(object);
		this.m_signals.releaseWithRollOut = false;
		this.m_signals.press.addOnce(onStart);
		
		this.startCb = null;
		this.moveCb = null;
		this.endCb = null;
	}
	
	
	private function setUpFromParent() : Void
	{
		if (m_targetObject == null)	
			return;
			
		if (m_targetObject.parent != null)
		{
			if (Std.is(m_targetObject.parent, Stage))
			{
				m_parentPosition.set(0, 0);
				m_parentScale.set(0, 0);
				var stage : Stage = cast m_targetObject.parent;
				setBoundary(0.0, 0.0, stage.stageWidth, stage.stageHeight);
			}
			else
			{
				m_parentPosition.set(m_targetObject.parent.x, m_targetObject.parent.y);
				m_parentScale.set(m_targetObject.parent.scaleX, m_targetObject.parent.scaleY);
				
				setBoundary(0, 0, m_targetObject.parent.width / m_parentScale.x, m_targetObject.parent.height / m_parentScale.y);
			}
		}			
			
	}
	
	/**
	 * set  boundary where drag is allowed. X/Y/W/H is local
	 * set -1 = unlimited 
	 * default : object parent x/y/w/h set the boundary at init
	 * @param	minX
	 * @param	minY
	 * @param	maxX
	 * @param	maxY
	 */
	private function setBoundary(minX : Float = -1, minY : Float = -1, maxX : Float = -1, maxY : Float = -1) : Void
	{
		m_minX = minX;
		m_minY = minY;
		
		if(maxX >= 0.0)
			m_maxX = maxX - m_targetObject.width;
		else
			m_maxX = maxX;
			
		if(maxY >= 0.0)
			m_maxY = maxY - m_targetObject.height;
		else
			m_maxY = maxY;
	}
	
	private function onStart(mousedata : PointerData)
	{
		try
		{
			if (m_actualPointerId != -1)
				return;
			
			m_actualPointerId = mousedata.pointerId;
			m_localStartPoint.copy(mousedata.localPosition);
			
			m_worldSignals.worldPointerMove.add(onMove);
			m_worldSignals.worldPointerRelease.add(onEnd);
			//m_worldSignals.leaveWorld.addOnce(onEnd);
			
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
			if (m_actualPointerId != mousedata.pointerId)
				return;
			
			setUpFromParent();
			lastCoord.copy(mousedata.worldPosition).substract(m_parentPosition).divide(m_parentScale).substract(m_localStartPoint);
			
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
	
	private function onEnd(mousedata : PointerData) : Void
	{
		try
		{
			if (m_actualPointerId != mousedata.pointerId)
				return;
			
			m_worldSignals.worldPointerMove.remove(onMove);
			m_worldSignals.worldPointerRelease.remove(onEnd);
			m_signals.press.addOnce(onStart);	
			
			lastCoord.x =  mousedata.worldPosition.x - m_localStartPoint.x;
			lastCoord.y =  mousedata.worldPosition.y - m_localStartPoint.y;		
			
			m_actualPointerId = -1;
			
			if (this.endCb != null)
				this.endCb(this.lastCoord);
			}
		catch (e : Dynamic)
		{
			trace("onEnd :"  + e);
		}
	}
	
	override public function delete():Void 
	{
		super.delete();
		startCb = null;
		moveCb = null;
		endCb = null;
		m_targetObject = null;
	}
	
}