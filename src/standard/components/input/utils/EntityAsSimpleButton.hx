package standard.components.input.utils;
import core.entity.Entity;
import input.behaviour.impl.SimpleButton;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.Display;

/**
 * ...
 * @author Breakyt
 */
enum ButtonAnimFrame
{
	normal;
	toggled;
	over;
	press;
}
 
 
class EntityAsSimpleButton extends EntityPointerBehaviour 
{

	private var m_toggleMode : Bool;
	
	private var m_displayRef : Display;
	
	private var m_animation : Animation;
	
	private var m_buttonBehaviour : SimpleButton;
	
	private var m_buttonAnimation : String;
	
	private var m_useAnimation : Bool;
	
	
	public var onSelect : Void->Void;
	public var onUnSelect : Void->Void;
	public var onRollOver : Void->Void;
	public var onRollOut : Void->Void;
	
	public function new(toggleMode : Bool, buttonAnimation : String = "button", useAnimation : Bool = true) 
	{
		super();
		m_toggleMode = toggleMode;
		m_buttonAnimation = buttonAnimation;
		m_buttonBehaviour = null;
		m_animation = null;
		m_useAnimation = useAnimation;
	}
	
	override public function setEntityRef(entityRef:Entity):Void 
	{
		super.setEntityRef(entityRef);
		
		m_displayRef = entityRef.getComponent(Display);
		
		if (m_useAnimation)
			m_animation = entityRef.getComponent(Animation);
		else
			m_animation = null;
		
		if (m_displayRef == null || m_displayRef.skin == null)
			return;
			
		if (m_animation != null)
		{
			m_animation.setAnim(m_buttonAnimation, false);
			m_animation.gotoAndStop(0);
		}
			
		m_buttonBehaviour = new SimpleButton(m_displayRef.skin, m_toggleMode);
		m_buttonBehaviour.onSelect = signalOnSelect;
		m_buttonBehaviour.onUnSelect = signalOnUnSelect;
		m_buttonBehaviour.onRollOver = signalOnRollOver;
		m_buttonBehaviour.onRollOut = signalOnRollOut;
		m_buttonBehaviour.onPress = signalOnPress;
		m_buttonBehaviour.onRelease = signalOnRelease;
	}
	
	override public function delete():Void 
	{
		super.delete();
	}
	
	private function signalOnSelect() : Void
	{
		if (m_animation != null)
			m_buttonBehaviour.toggled ? m_animation.gotoAndStop(ButtonAnimFrame.toggled.getIndex()) : m_animation.gotoAndStop(ButtonAnimFrame.normal.getIndex());
		
		if (onSelect != null)
			onSelect();
	}
	
	private function signalOnUnSelect() : Void
	{
		if (m_animation != null)
			m_buttonBehaviour.toggled ? m_animation.gotoAndStop(ButtonAnimFrame.toggled.getIndex()) : m_animation.gotoAndStop(ButtonAnimFrame.normal.getIndex());
			
		if (onUnSelect != null)
			onUnSelect();
	}
	
	private function signalOnRollOver() : Void
	{
		if (m_animation != null)
			m_animation.gotoAndStop(ButtonAnimFrame.over.getIndex());
		
		if (onRollOver != null)
			onRollOver();
	}
	
	private function signalOnRollOut() : Void
	{
		if (m_animation != null)
			m_buttonBehaviour.toggled ? m_animation.gotoAndStop(ButtonAnimFrame.toggled.getIndex()) : m_animation.gotoAndStop(ButtonAnimFrame.normal.getIndex());
			
		if (onRollOut != null)
			onRollOut();
	}	
	
	private function signalOnPress() : Void
	{
		if (m_animation != null)
			m_animation.gotoAndStop(ButtonAnimFrame.press.getIndex());
	}
	
	
	private function signalOnRelease() : Void
	{
		if (m_animation != null)
			m_buttonBehaviour.toggled ? m_animation.gotoAndStop(ButtonAnimFrame.toggled.getIndex()) : m_animation.gotoAndStop(ButtonAnimFrame.normal.getIndex());
	}
}