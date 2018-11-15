package input.behaviour.impl;

import input.behaviour.PointerBehaviour;
import input.IPointerSignals;
import input.WorldSignal;
import input.data.PointerData;
import input.pointerImpl.BasicPointerSignals;
import openfl.display.InteractiveObject;

/**
 * ...
 * @author Breakyt
 */
class SimpleButton extends PointerBehaviour 
{
	private var m_targetObject: InteractiveObject;
	
	public var toggleMode(default,null) : Bool;
	
	public var toggled(default,null) : Bool;
	
	public var onSelect : Void->Void;
	public var onUnSelect : Void->Void;
	public var onRollOver : Void->Void;
	public var onRollOut : Void->Void;
	public var onPress : Void->Void;
	public var onRelease : Void->Void;
	
	public function new(targetObject : InteractiveObject, toggleMode : Bool = false, enableAtStart : Bool = true) 
	{
		super(null);
		m_targetObject = targetObject;
		this.toggleMode = toggleMode;
		this.toggled = false;
		this.setEnable(enable);
		this.m_signals = new BasicPointerSignals(m_targetObject);
		
		this.m_signals.click.add(signalOnSelect);
		this.m_signals.rollOver.add(signalOnRollOver);
		this.m_signals.rollOut.add(signalOnRollOut);
		this.m_signals.press.add(signalOnPress);
		this.m_signals.release.add(signalOnRelease);
	}
	
	
	private function signalOnSelect(data :PointerData) : Void
	{
		if (data.pointerId > 0)
			return;
		
		if (!this.enable)
			return;
			
		if (toggleMode)
			this.toggled = !this.toggled;
			
		if (this.toggled  && onUnSelect != null)
			onUnSelect();
		else if (!this.toggled && onSelect != null)
			onSelect();
	}
	
	
	private function signalOnRollOver(data :PointerData) : Void
	{
		if (data.pointerId > 0)
			return;
			
		if (onRollOver != null && this.enable)
			onRollOver();
	}
	
	private function signalOnRollOut(data :PointerData) : Void
	{
		if (data.pointerId > 0)
			return;
			
		if (onRollOut != null && this.enable)
			onRollOut();
	}
	
	private function signalOnPress(data :PointerData) : Void
	{
		if (data.pointerId > 0)
			return;
			
		if (onPress != null && this.enable)
			onPress();
	}
	
	private function signalOnRelease(data :PointerData) : Void
	{
		
		if (data.pointerId > 0)
			return;
			
		if (onRelease != null && this.enable)
			onRelease();
	}
	
	public function setEnable(enable : Bool = true) : Void
	{
		this.enable = enable;
	}
	
}