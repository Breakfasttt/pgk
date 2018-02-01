package input.pointerImpl;

import input.IPointerSignals;
import input.data.PointerData;
import msignal.Signal.Signal1;
import openfl.display.InteractiveObject;
import openfl.events.TouchEvent;
import tools.event.EventChecker;

/**
 * ...
 * @author Breakyt
 */
class BasicTouchSignals implements IPointerSignals 
{

	public var objectRef(default, null):InteractiveObject;
	
	/**
	 * The event checker to add/remove event on the objectRef
	 */
	private var m_eventChecker : EventChecker;	
	
	/**
	 * Enable/disable the mouse move event on objectRef.
	 * default = false.
	 */
	public var localMoveEnable(default, set) : Bool;
	
	/**
	 * An help variable send by all signal. (read only)
	 */
	private var m_lastMouseData : PointerData;	
	
	/**
	 * enable/disable release with roll out mode
	 * enable : when roll out is detect, all release signals are dispatch
	 * Else, nothing append
	 * default = true;
	 */	
	public var releaseWithRollOut:Bool;
	
	/**
	 * Signal dispatch when a left-press happen (left mouse button hold down)
	 * leftClickEnable must be set as true
	 */
	public var press:Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a left-release happen (left mouse button just up/release)
	 * leftClickEnable must be set as true
	 */
	public var release:Signal1<PointerData>;
	
	/**
	 * Signal dispatch when mouse move only on this.object
	 * moveEnable must be set as true
	 */	
	public var move:Signal1<PointerData>;
	
	/**
	 * Signal dispatch when roll over the interactive object
	 */	
	public var rollOver:Signal1<PointerData>;
	
	/**
	 * Signal dispatch when roll out the interactive object 
	 */	
	public var rollOut:Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a left-click (press and release action) happen.
	 * leftClickEnable must be set as true
	 */	
	public var click:Signal1<PointerData>;	
	
	/**
	 * Signal dispatch when a left-click (press and release action) happen.
	 * leftClickEnable must be set as true
	 */	
	public var doubleClick:Signal1<PointerData>;
	
	
	/**
	 * to detect double tap
	 */
	private var m_tapStartTime : Float;
	
	/**
	 * tools boolean for double tap
	 */
	private var m_doubleTapAlreadyMade : Bool;
	
	public function new(interactiveObject : InteractiveObject) 
	{
		this.objectRef = interactiveObject;
		
		m_eventChecker = new EventChecker(this.objectRef);
		
		m_lastMouseData = new PointerData();
		
		this.click = new Signal1<PointerData>();
		this.doubleClick = new Signal1<PointerData>();
		this.press = new Signal1<PointerData>();
		this.release = new Signal1<PointerData>();
		this.move = new Signal1<PointerData>();
		this.rollOver = new Signal1<PointerData>();
		this.rollOut = new Signal1<PointerData>();
	
		this.localMoveEnable = false;
		this.releaseWithRollOut = true;	
		
		m_tapStartTime = 0.0;
		m_doubleTapAlreadyMade = false;
		
	}
	
	private function set_localMoveEnable(value:Bool):Bool 
	{
		this.removeListeners();
		localMoveEnable = value;
		this.attachListeners();
		return localMoveEnable;
	}	
	
	/**
	 * Attach MouseEvent Listener depending of mouse behaviour (left/right/scroll/move enable)
	 */
	private function attachListeners() : Void
	{
		m_eventChecker.addEvent(TouchEvent.TOUCH_OUT, onRollOut);
		m_eventChecker.addEvent(TouchEvent.TOUCH_OVER, onRollOver);
		m_eventChecker.addEvent(TouchEvent.TOUCH_TAP, onClick);
		//m_eventChecker.addEvent(TouchEvent.DOUBLE_CLICK, onDoubleClick);
		m_eventChecker.addEvent(TouchEvent.TOUCH_BEGIN, onTouchDown);
		m_eventChecker.addEvent(TouchEvent.TOUCH_END, onTouchUp);
		
		if (this.localMoveEnable)
			m_eventChecker.addEvent(TouchEvent.TOUCH_MOVE, onLocalMouseMove);
	}
	
	/**
	 * remove all MouseEvent Listener
	 */
	private function removeListeners() : Void
	{
		m_eventChecker.removeEvent(TouchEvent.TOUCH_ROLL_OUT);
		m_eventChecker.removeEvent(TouchEvent.TOUCH_ROLL_OVER);
		m_eventChecker.removeEvent(TouchEvent.TOUCH_TAP);
		m_eventChecker.removeEvent(TouchEvent.TOUCH_BEGIN);
		m_eventChecker.removeEvent(TouchEvent.TOUCH_END);
		m_eventChecker.removeEvent(TouchEvent.TOUCH_MOVE);
	}
	
	//{ ==== Mouse event handling ====
	
	private function onClick(event : TouchEvent) : Void
	{
		var now : Float = Date.now().getTime();
		
		if (now - m_tapStartTime < 500 && !m_doubleTapAlreadyMade)
		{
			m_doubleTapAlreadyMade = true;
			this.doubleClick.dispatch(m_lastMouseData);	
		}
		else
		{
			m_doubleTapAlreadyMade = false;
			m_tapStartTime = now;
			m_lastMouseData.retrieveEventData(event);
			this.click.dispatch(m_lastMouseData);
		}
	}
	
	private function onDoubleClick(event : TouchEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.doubleClick.dispatch(m_lastMouseData);
	}
	
	private function onTouchDown(event : TouchEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.press.dispatch(m_lastMouseData);
	}
	
	private function onTouchUp(event : TouchEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.release.dispatch(m_lastMouseData);
	}
	
	private function onLocalMouseMove(event : TouchEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.move.dispatch(m_lastMouseData);
	}

	private function onRollOut(event : TouchEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rollOut.dispatch(m_lastMouseData);
		
		if (releaseWithRollOut)
			this.release.dispatch(m_lastMouseData);
			
	}
	
	private function onRollOver(event : TouchEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rollOver.dispatch(m_lastMouseData);
	}
	
	//} ========================================	
	
	
}