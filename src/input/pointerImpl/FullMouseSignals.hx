package input.pointerImpl;

import input.data.PointerData;
import msignal.Signal.Signal1;
import openfl.display.InteractiveObject;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Breakyt
 */
class FullMouseSignals extends BasicMouseSignals 
{

	/**
	 * Signal dispatch when a mouse scroll button click happen (press and release action)
	 * scrollEnable must be set as true
	 */
	public var scrollClick : Signal1<PointerData>;
	
	
	/**
	 * Signal dispatch when a mouse scroll button-press happen (scroll mouse button hold down)
	 * scrollEnable must be set as true
	 */
	public var scrollPress : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a mouse scroll button-release happen (scroll mouse button just up/release)
	 * scrollEnable must be set as true
	 */
	public var scrollRelease : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when mouse scroll
	 * scrollEnable must be set as true
	 */
	public var scroll : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a right-click happen(press and release action).
	 * rightClickEnable must be set as true
	 */
	public var rightClick: Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a right-press happen (right mouse button hold down)
	 * rightClickEnable must be set as true
	 */
	public var rightPress : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a right-release happen (right mouse button just up/release)
	 * rightClickEnable must be set as true
	 */
	public var rightRelease : Signal1<PointerData>;	
	
	public function new(interactiveObject:InteractiveObject) 
	{
		super(interactiveObject);
		
		this.rightClick = new Signal1<PointerData>();
		this.rightPress = new Signal1<PointerData>();
		this.rightRelease = new Signal1<PointerData>();
		this.scrollClick = new Signal1<PointerData>();
		this.scrollPress = new Signal1<PointerData>();
		this.scrollRelease = new Signal1<PointerData>();
		this.scroll = new Signal1<PointerData>();	
	}
	
	override function attachListeners():Void 
	{
		super.attachListeners();
		
		m_eventChecker.addEvent(MouseEvent.MIDDLE_CLICK, onMiddleClick);
		m_eventChecker.addEvent(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		m_eventChecker.addEvent(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
		m_eventChecker.addEvent(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);

		m_eventChecker.addEvent(MouseEvent.RIGHT_CLICK, onRightClick);
		m_eventChecker.addEvent(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
		m_eventChecker.addEvent(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);	
		
	}
	
	override function removeListeners():Void 
	{
		super.removeListeners();
		
		m_eventChecker.removeEvent(MouseEvent.MIDDLE_CLICK, onMiddleClick);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		m_eventChecker.removeEvent(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
		m_eventChecker.removeEvent(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);

		m_eventChecker.removeEvent(MouseEvent.RIGHT_CLICK, onRightClick);
		m_eventChecker.removeEvent(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
		m_eventChecker.removeEvent(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);			
		
	}
	
	//{ ==== Mouse middle button  event handling  ====
	
	private function onMiddleMouseDown(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.scrollPress.dispatch(m_lastMouseData);
	}
	
	private function onMiddleMouseUp(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.scrollRelease.dispatch(m_lastMouseData);
	}
	
	private function onMiddleClick(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.scrollClick.dispatch(m_lastMouseData);
	}
	
	private function onMouseWheel(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.scroll.dispatch(m_lastMouseData);
	}
	
	//} ========================================
	
	//{ ==== Mouse right button  event handling  ====
	
	private function onRightClick(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rightClick.dispatch(m_lastMouseData);
	}
	
	private function onRightMouseDown(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rightPress.dispatch(m_lastMouseData);
	}
	
	private function onRightMouseUp(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rightRelease.dispatch(m_lastMouseData);
	}
	
	//} ========================================
	
	override public function delete():Void 
	{
		removeListeners();
		
		this.click.removeAll();
		this.doubleClick.removeAll();
		this.press.removeAll();
		this.release.removeAll();
		this.move.removeAll();
		this.rollOver.removeAll();
		this.rollOut.removeAll();
		this.rightClick.removeAll();
		this.rightPress.removeAll();
		this.rightRelease.removeAll();
		this.scrollClick.removeAll();
		this.scrollPress.removeAll();
		this.scrollRelease.removeAll();
		this.scroll.removeAll();
		
		this.click = null;
		this.doubleClick = null;
		this.press = null;
		this.release = null;
		this.move = null;
		this.rollOver = null;
		this.rollOut = null;		
		this.rightClick = null;
		this.rightPress = null;
		this.rightRelease = null;
		this.scrollClick = null;
		this.scrollPress = null;
		this.scrollRelease = null;
		this.scroll = null;	
		
		this.objectRef = null;
	}
}