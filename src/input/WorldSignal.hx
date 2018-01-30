package input;
import msignal.Signal.Signal1;
import openfl.Lib;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.MouseEvent;
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
	public var leaveWorld : Signal1<Event>;

	/**
	 * Signal dispatch when a pointer (Touch/Mouse) move anywhere on the stage
	 */
	public var worldPointerMove : Signal1<Event>;
	
	/**
	 * Signal dispatch when a pointer (Touch/Mouse) press anywhere on the stage
	 * @param	stageRef
	 */
	public var worldPointerPress : Signal1<Event>
	
	/**
	 * Signal dispatch when a pointer (Touch/Mouse) press anywhere on the stage
	 * @param	stageRef
	 */
	public var worldPointerRelease : Signal1<Event>
	
	public function new(stageRef : Stage = null) 
	{
		m_stageRef = stageRef;
		
		if (m_stageRef == null)
			m_stageRef = Lib.current.stage;
		
		m_eventChecker = new EventChecker(m_stageRef);
		
		this.leaveWorld = new Signal1();
		this.worldPointerMove = new Signal1();
		this.worldPointerPress = new Signal1();
		this.worldPointerRelease = new Signal1();
		
		addListeners();
	}
	
	private function addListeners() : Void
	{
		m_eventChecker.addEvent(Event.MOUSE_LEAVE, onMouseLeaveWorld);
		m_eventChecker.addEvent(MouseEvent.RELEASE_OUTSIDE, onMouseLeaveWorld);
		m_eventChecker.addEvent(MouseEvent.MOUSE_MOVE, onWorldMouseMove);
		m_eventChecker.addEvent(MouseEvent.MOUSE_UP, onMouseUp);
		m_eventChecker.addEvent(MouseEvent.MOUSE_DOWN, onMouseUp);
	}
	
	private function removeListeners() : Void
	{
		m_eventChecker.removeEvent(Event.MOUSE_LEAVE);
		m_eventChecker.removeEvent(MouseEvent.RELEASE_OUTSIDE);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_MOVE);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_UP);
		m_eventChecker.removeEvent(MouseEvent.MOUSE_DOWN);
	}
	
	private function onMouseLeaveWorld(event : Event) : Void
	{
		this.leaveWorld.dispatch(m_lastMouseData);
	}
	
	private function onWorldMouseMove(event : MouseEvent) : Void
	{
		this.worldMove.dispatch(m_lastMouseData);
		
		//remove this when refactoring is finish, keep the code only
		/*
		if (objectRef.stage != null)
		{
			if (m_lastMouseData.worldPosition.x < 0.0 || m_lastMouseData.worldPosition.x > objectRef.stage.stageWidth
				||  m_lastMouseData.worldPosition.y < 0.0 || m_lastMouseData.worldPosition.y > objectRef.stage.stageHeight)
			{
				onMouseLeaveStage(null);
			}
		}*/
	}	
	
	static function get_self():WorldSignal 
	{
		if (self == null)
			self = new WorldSignal();
		return self;
	}

	
}