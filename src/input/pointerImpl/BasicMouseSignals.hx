package input.pointerImpl;
import input.data.PointerData;
import msignal.Signal.Signal1;
import openfl.display.InteractiveObject;
import openfl.events.Event;
import openfl.events.MouseEvent;
import tools.event.EventChecker;

/**
 * ...
 * @author Breakyt
 */
class BasicMouseSignals implements IPointerSignals
{

	/**
	 * The interactive object who listen mouse signal
	 */
	public var objectRef(default, null) : InteractiveObject;
	
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
	 * enable/disable release with roll out mode
	 * enable : when roll out is detect, all release signals are dispatch
	 * Else, nothing append
	 * default = true;
	 */
	public var releaseWithRollOut : Bool;	
	
	/**
	 * Signal dispatch when a left-click (press and release action) happen.
	 * leftClickEnable must be set as true
	 */
	public var click : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a double left-click (press and release action *2) happen.
	 * leftClickEnable must be set as true
	 */
	public var doubleClick : Signal1<PointerData>;

	/**
	 * Signal dispatch when a left-press happen (left mouse button hold down)
	 * leftClickEnable must be set as true
	 */
	public var press : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a left-release happen (left mouse button just up/release)
	 * leftClickEnable must be set as true
	 */
	public var release : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when mouse move only on this.object
	 * moveEnable must be set as true
	 */
	public var move : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when roll over the interactive object
	 */
	public var rollOver : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when roll out the interactive object 
	 */
	public var rollOut : Signal1<PointerData>;
	
	/**
	 * An help variable send by all signal. (read only)
	 */
	private var m_lastMouseData : PointerData;
	
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
		
		attachListeners();
	}

	/**
	 * Attach MouseEvent Listener depending of mouse behaviour (left/right/scroll/move enable)
	 */
	private function attachListeners() : Void
	{
		m_eventChecker.addEvent(MouseEvent.ROLL_OUT, onRollOut);
		m_eventChecker.addEvent(MouseEvent.ROLL_OVER, onRollOver);
		m_eventChecker.addEvent(MouseEvent.CLICK, onClick);
		m_eventChecker.addEvent(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		m_eventChecker.addEvent(MouseEvent.MOUSE_DOWN, onMouseDown);
		m_eventChecker.addEvent(MouseEvent.MOUSE_UP, onMouseUp);
		
		if (this.localMoveEnable)
			m_eventChecker.addEvent(MouseEvent.MOUSE_MOVE, onLocalMouseMove);
	}
	
	/**
	 * remove all MouseEvent Listener
	 */
	private function removeListeners() : Void
	{
		m_eventChecker.removeEvent(MouseEvent.ROLL_OUT);
		m_eventChecker.removeEvent(MouseEvent.ROLL_OUT);
		m_eventChecker.removeEvent(MouseEvent.CLICK);
		m_eventChecker.removeEvent(MouseEvent.DOUBLE_CLICK);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_DOWN);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_UP);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_MOVE);
	}
	
	//{ ==== Mouse event handling ====
	
	private function onClick(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.click.dispatch(m_lastMouseData);
	}
	
	private function onDoubleClick(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.doubleClick.dispatch(m_lastMouseData);
	}
	
	private function onMouseDown(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.press.dispatch(m_lastMouseData);
	}
	
	private function onMouseUp(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.release.dispatch(m_lastMouseData);
	}
	
	private function onLocalMouseMove(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.move.dispatch(m_lastMouseData);
	}

	private function onRollOut(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rollOut.dispatch(m_lastMouseData);
		
		if (releaseWithRollOut)
			this.release.dispatch(m_lastMouseData);
	}
	
	private function onRollOver(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rollOver.dispatch(m_lastMouseData);
	}
	
	//} ========================================
	
	
	//{ == public function ==
	
	/**
	 * enable mouse event on the interactive Object
	 * @param	enable
	 */
	public function enable(enable : Bool = true) : Void
	{
		if (this.objectRef == null)
			return;
			
		this.objectRef.mouseEnabled = enable;
	}
	
	public function delete() : Void
	{
		removeListeners();
		
		this.click.removeAll();
		this.doubleClick.removeAll();
		this.press.removeAll();
		this.release.removeAll();
		this.move.removeAll();
		this.rollOver.removeAll();
		this.rollOut.removeAll();
		
		this.click = null;
		this.doubleClick = null;
		this.press = null;
		this.release = null;

		this.move = null;
		this.rollOver = null;
		this.rollOut = null;
		
		this.objectRef = null;
	}
	
	private function set_localMoveEnable(value:Bool):Bool 
	{
		this.removeListeners();
		localMoveEnable = value;
		this.attachListeners();
		return localMoveEnable;
	}
	
	//} ========================================
	
}