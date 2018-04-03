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
	 * the target object who listen pointer signals
	 */
	private var m_targetObject : InteractiveObject;
	
	/**
	 * var save to get the pointer id who start the drag
	 */
	private var m_actualPointerId : Int;
	
	/**
	 * Callback when drag start with Last world PointerData  in parameters
	 */
	public var startCb : PointerData->Void;
	
	/**
	 * Callback when drag move with Last world PointerData  in parameters
	 */
	public var moveCb : PointerData->Void;
	
	/**
	 * Callback when end start with Last world PointerData  in parameters
	 */
	public var endCb : PointerData->Void;
	
	/**
	 * Create a simple Drag behaviour 
	 * @param	object : The object where pointer callback 
	 */
	public function new(object : InteractiveObject) : Void
	{
		super(null);
		
		m_targetObject = object;
		m_actualPointerId = -1;
		
		this.m_signals = new BasicPointerSignals(object);
		this.m_signals.releaseWithRollOut = false;
		this.m_signals.press.addOnce(onStart);
		
		this.startCb = null;
		this.moveCb = null;
		this.endCb = null;
	}
	
	private function onStart(mousedata : PointerData)
	{
		if (!this.enable)
		{
			this.m_signals.press.addOnce(onStart);
			m_actualPointerId = -1;
			return;
		}
		
		try
		{
			if (m_actualPointerId != -1)
				return;
			
			m_actualPointerId = mousedata.pointerId;
			m_worldSignals.worldPointerMove.add(onMove);
			m_worldSignals.worldPointerRelease.add(onEnd);
			//m_worldSignals.leaveWorld.addOnce(onEnd);
			
			if (this.startCb != null)
				this.startCb(mousedata);
		}
		catch (e : Dynamic)
		{
			trace("onStart :"  + e);
		}
	}
	
	private function onMove(mousedata : PointerData) : Void
	{
		//try
		//{
			if (m_actualPointerId != mousedata.pointerId)
				return;
			
			if (this.moveCb != null)
				this.moveCb(mousedata);
		//}
		//catch (e : Dynamic)
		//{
			//trace("onMove :"  + e);
		//}
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
			
			m_actualPointerId = -1;
			
			if (this.endCb != null)
				this.endCb(mousedata);
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