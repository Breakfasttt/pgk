package input;
import input.data.PointerData;
import msignal.Signal.Signal1;
import openfl.Lib;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import tools.event.EventChecker;

/**
 * ...
 * @author Breakyt
 */
class WorldSignal 
{

	/**
	 * A static var to get World signal anywhere.
	 */
	public static var self(get, null) : WorldSignal;
	
	/**
	 * The stage Reference
	 */
	private var m_stageRef : Stage;
	
	/**
	 * The event checker to add/remove event on the stage
	 */
	private var m_eventChecker : EventChecker;	
	
	/**
	 * Signal dispatch when mouse leave the stage
	 */
	public var leaveWorld : Signal1<PointerData>;

	/**
	 * Signal dispatch when a pointer (Touch/Mouse) move anywhere on the stage
	 */
	public var worldPointerMove : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a pointer (Touch/Mouse) press anywhere on the stage
	 * @param	stageRef
	 */
	public var worldPointerPress : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when a pointer (Touch/Mouse) press anywhere on the stage
	 * @param	stageRef
	 */
	public var worldPointerRelease : Signal1<PointerData>;
	
	/**
	 * PointerData dispatched
	 */
	private var m_lastMouseData : PointerData;
	
	public function new(stageRef : Stage = null) 
	{
		m_stageRef = stageRef;
		
		if (m_stageRef == null)
			m_stageRef = Lib.current.stage;
		
		m_eventChecker = new EventChecker(m_stageRef);
		
		m_lastMouseData = new PointerData();
		
		this.leaveWorld = new Signal1<PointerData>();
		this.worldPointerMove = new Signal1<PointerData>();
		this.worldPointerPress = new Signal1<PointerData>();
		this.worldPointerRelease = new Signal1<PointerData>();
		
		addListeners();
	}
	
	private function addListeners() : Void
	{
		m_eventChecker.addEvent(Event.MOUSE_LEAVE, onMouseLeaveWorld);
		
		#if !android //todo improve this
		m_eventChecker.addEvent(MouseEvent.RELEASE_OUTSIDE, onMouseLeaveWorld);
		m_eventChecker.addEvent(MouseEvent.MOUSE_MOVE, onWorldMouseMove);
		m_eventChecker.addEvent(MouseEvent.MOUSE_UP, onMouseUp);
		m_eventChecker.addEvent(MouseEvent.MOUSE_DOWN, onMouseDown);
		#else
		m_eventChecker.addEvent(TouchEvent.TOUCH_BEGIN, onMouseDown);
		m_eventChecker.addEvent(TouchEvent.TOUCH_END, onMouseUp);
		m_eventChecker.addEvent(TouchEvent.TOUCH_MOVE, onWorldMouseMove);
		#end
	}
	
	private function removeListeners() : Void
	{
		
		m_eventChecker.removeEvent(Event.MOUSE_LEAVE);
		
		#if !android
		m_eventChecker.removeEvent(MouseEvent.RELEASE_OUTSIDE);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_MOVE);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_UP);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_DOWN);
		#else
		m_eventChecker.removeEvent(TouchEvent.TOUCH_BEGIN);
		m_eventChecker.removeEvent(TouchEvent.TOUCH_END);
		m_eventChecker.removeEvent(TouchEvent.TOUCH_MOVE);
		#end
	}
	
	private function onMouseLeaveWorld(event : Event) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.leaveWorld.dispatch(m_lastMouseData);
	}
	
	private function onWorldMouseMove(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.worldPointerMove.dispatch(m_lastMouseData);
		

		if (	m_lastMouseData.worldPosition.x < 0.0 || m_lastMouseData.worldPosition.x > m_stageRef.stageWidth
			||  m_lastMouseData.worldPosition.y < 0.0 || m_lastMouseData.worldPosition.y > m_stageRef.stageHeight)
		{
			onMouseLeaveWorld(null);
		}
	}
	
	private function onMouseUp(event : Event) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.worldPointerRelease.dispatch(m_lastMouseData);
	}
	
	private function onMouseDown(event : Event) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.worldPointerPress.dispatch(m_lastMouseData);
	}
	
	static function get_self():WorldSignal 
	{
		if (self == null)
			self = new WorldSignal();
		return self;
	}

	
}