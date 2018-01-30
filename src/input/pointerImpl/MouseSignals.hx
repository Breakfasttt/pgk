package input.pointerImpl;
import input.data.PointerData;
import msignal.Signal.Signal1;
import openfl.display.InteractiveObject;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Breakyt
 */
class MouseSignals implements IPointerSignals
{

	/**
	 * The interactive object who listen mouse signal
	 */
	public var objectRef(default, null) : InteractiveObject;
	
	/**
	 * enable/disable all left mouse button signal
	 * if you want enable/disable all mouses signal type, use public function enable() instead of this
	 */
	public var leftClickEnable(default, set) : Bool;
	
	/**
	 * enable/disable all right mouse button signal
	 * if you want enable/disable all mouses signal type, use public function enable() instead of this
	 */
	public var rightClickEnable(default, set) : Bool;
	
	/**
	 * enable/disable all scroll mouse button signal
	 * if you want enable/disable all mouses signal type, use public function enable() instead of this
	 */
	public var scrollEnable(default, set) : Bool;
	
	/**
	 * enable/disable local mouse movement signal
	 * if you want enable/disable all mouses signal type, use public function enable() instead of this
	 */
	public var localMoveEnable(default, set) : Bool;
	
	/**
	 * enable/disable world mouse movement signal
	 * if you want enable/disable all mouses signal type, use public function enable() instead of this
	 */
	public var worldMoveEnable(default, set) : Bool;
	
	/**
	 * enable/disable release outside target mode
	 * enable : all releases signals is call when you release any mouse button anywhere on world/stage. 
	 * Else, all release signals was call only if mouse is on target.
	 * override releaseWithRollOut
	 * default = false;
	 */
	public var releaseOutsideObject(default, set) : Bool;
	
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
	
	public function new(interactiveObject : InteractiveObject, leftClick : Bool = true, rightClick :  Bool = false, scroll : Bool = false, localMove : Bool = false, worldMove : Bool = false) 
	{
		this.objectRef = interactiveObject;
		
		this.m_lastMouseData = new PointerData();
		
		this.click = new Signal1<PointerData>();
		this.doubleClick = new Signal1<PointerData>();
		this.press = new Signal1<PointerData>();
		this.release = new Signal1<PointerData>();
		this.rightClick = new Signal1<PointerData>();
		this.rightPress = new Signal1<PointerData>();
		this.rightRelease = new Signal1<PointerData>();
		this.scrollClick = new Signal1<PointerData>();
		this.scrollPress = new Signal1<PointerData>();
		this.scrollRelease = new Signal1<PointerData>();
		this.scroll = new Signal1<PointerData>();
		this.move = new Signal1<PointerData>();
		this.rollOver = new Signal1<PointerData>();
		this.rollOut = new Signal1<PointerData>();
		
		
		this.releaseOutsideObject = false;
		this.releaseWithRollOut = true;
		
		this.leftClickEnable = leftClick;
		this.rightClickEnable = rightClick;
		this.scrollEnable = scroll;
		this.localMoveEnable = localMove;
		this.worldMoveEnable = worldMove;
		
		attachListeners();
	}
	
	/**
	 * setter of leftClickEnable
	 * @param	value
	 */
	private function set_leftClickEnable(value : Bool) : Bool
	{
		removeListeners();
		this.leftClickEnable = value;
		attachListeners();	
		return this.leftClickEnable;
	}
	
	/**
	 * setter of rightClickEnable
	 * @param	value
	 */
	private function set_rightClickEnable(value : Bool) : Bool
	{
		removeListeners();
		this.rightClickEnable = value;
		attachListeners();	
		return this.rightClickEnable;
	}
	
	/**
	 * setter of scrollEnable
	 * @param	value
	 */
	private function set_scrollEnable(value : Bool) : Bool
	{
		removeListeners();
		this.scrollEnable = value;
		attachListeners();
		return this.scrollEnable;
	}
	
	/**
	 * setter of localMoveEnable
	 * @param	value
	 */
	private function set_localMoveEnable(value : Bool) : Bool
	{
		removeListeners();
		this.localMoveEnable = value;
		attachListeners();
		return this.localMoveEnable;
	}
	
	/**
	 * Setter of worldMoveEnable
	 * @param	value
	 * @return
	 */
	private function set_worldMoveEnable(value : Bool) : Bool
	{
		removeListeners();
		this.worldMoveEnable = value;
		attachListeners();
		return this.worldMoveEnable;
	}
	
	/**
	 * Setter of worldMoveEnable
	 * @param	value
	 * @return
	 */
	private function set_releaseOutsideObject(value : Bool) : Bool
	{
		removeListeners();
		this.releaseOutsideObject = value;
		attachListeners();
		return this.releaseOutsideObject;
	}
	
	/**
	 * Attach MouseEvent Listener depending of mouse behaviour (left/right/scroll/move enable)
	 */
	private function attachListeners() : Void
	{
		if (this.objectRef == null)
			return;
			
		if(!objectRef.hasEventListener(MouseEvent.ROLL_OUT))	
			objectRef.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
		if(!objectRef.hasEventListener(MouseEvent.ROLL_OVER))	
			objectRef.addEventListener(MouseEvent.ROLL_OVER, onRollOver);			
			
		if (this.leftClickEnable)
		{
			if(!objectRef.hasEventListener(MouseEvent.CLICK))	
				objectRef.addEventListener(MouseEvent.CLICK, onClick);
			
			if(!objectRef.hasEventListener(MouseEvent.DOUBLE_CLICK))	
				objectRef.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
				
			if(!objectRef.hasEventListener(MouseEvent.MOUSE_DOWN))	
				objectRef.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			if(!releaseOutsideObject && !objectRef.hasEventListener(MouseEvent.MOUSE_UP))	
				objectRef.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		if (this.scrollEnable)
		{
			if(!objectRef.hasEventListener(MouseEvent.MIDDLE_CLICK))	
				objectRef.addEventListener(MouseEvent.MIDDLE_CLICK, onMiddleClick);
			
			if(!objectRef.hasEventListener(MouseEvent.MOUSE_WHEEL))	
				objectRef.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
			if(!objectRef.hasEventListener(MouseEvent.MIDDLE_MOUSE_DOWN))	
				objectRef.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
			
			if(!releaseOutsideObject && !objectRef.hasEventListener(MouseEvent.MIDDLE_MOUSE_UP))	
				objectRef.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);		
		}
		
		if (this.rightClickEnable)
		{
			if(!objectRef.hasEventListener(MouseEvent.RIGHT_CLICK))	
				objectRef.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
				
			if(!objectRef.hasEventListener(MouseEvent.RIGHT_MOUSE_DOWN))
				objectRef.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
				
			if(!releaseOutsideObject && !objectRef.hasEventListener(MouseEvent.RIGHT_MOUSE_UP))	
				objectRef.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
		}
		
		if(this.localMoveEnable && !objectRef.hasEventListener(MouseEvent.MOUSE_MOVE))	
			objectRef.addEventListener(MouseEvent.MOUSE_MOVE, onLocalMouseMove);
	}
	
	
	/**
	 * remove all MouseEvent Listener
	 */
	private function removeListeners() : Void
	{
		if (this.objectRef == null)
			return;
			
		if(objectRef.hasEventListener(MouseEvent.CLICK))	
			objectRef.removeEventListener(MouseEvent.CLICK, onClick);
		
		if(objectRef.hasEventListener(MouseEvent.DOUBLE_CLICK))	
			objectRef.removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		
		if(objectRef.hasEventListener(MouseEvent.MOUSE_DOWN))	
			objectRef.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		
		if(objectRef.hasEventListener(MouseEvent.MOUSE_UP))	
			objectRef.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
		if(objectRef.hasEventListener(MouseEvent.MIDDLE_CLICK))	
			objectRef.removeEventListener(MouseEvent.MIDDLE_CLICK, onMiddleClick);
		
		if(objectRef.hasEventListener(MouseEvent.MIDDLE_MOUSE_DOWN))	
			objectRef.removeEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
		
		if(objectRef.hasEventListener(MouseEvent.MIDDLE_MOUSE_UP))	
			objectRef.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);
			
		if(objectRef.hasEventListener(MouseEvent.MOUSE_WHEEL))	
			objectRef.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
		if(objectRef.hasEventListener(MouseEvent.RIGHT_CLICK))	
			objectRef.removeEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			
		if(objectRef.hasEventListener(MouseEvent.RIGHT_MOUSE_DOWN))	
			objectRef.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
			
		if(objectRef.hasEventListener(MouseEvent.RIGHT_MOUSE_UP))	
			objectRef.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
			
		if(objectRef.hasEventListener(MouseEvent.MOUSE_MOVE))	
			objectRef.removeEventListener(MouseEvent.MOUSE_MOVE, onLocalMouseMove);
			
		if(objectRef.hasEventListener(MouseEvent.RELEASE_OUTSIDE))	
			objectRef.removeEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);			
			
		if(objectRef.hasEventListener(MouseEvent.ROLL_OUT))	
			objectRef.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
		if(objectRef.hasEventListener(MouseEvent.ROLL_OVER))	
			objectRef.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
	}
	
	
	/**
	 * refresh listener when the object is added to the stage.
	 * Usefull for stage event listener like Release_outside
	 * @param	event
	 */
	private function onAddedToStage(event : Event)
	{
		this.objectRef.stage.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		this.removeListeners();
		this.attachListeners();
	}
	
	private function onRemoveFromStage(event : Event)
	{
		this.objectRef.stage.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		this.removeListeners();
		this.attachListeners();
	}
	

	
	//{ ==== Mouse Left button event handling ====
	
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
	
	//} ========================================
	
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
	
	
	//{ == mouse move  event handling  ==
	
	private function onLocalMouseMove(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.move.dispatch(m_lastMouseData);
	}
	

	
	//} ========================================
	
	
	//{ == generic mouse  event handling  ==
	
	private function onReleaseOutside(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.release.dispatch(m_lastMouseData);
	}
	
	private function onMouseLeaveStage(event : Event) : Void
	{
		m_lastMouseData.altModifier = false;
		m_lastMouseData.ctrlModifier = false;
		m_lastMouseData.deltaScroll = 0;
		m_lastMouseData.localPosition.set(0, 0);
		m_lastMouseData.target = null;
		m_lastMouseData.worldPosition.set(0, 0);
		//this.leaveWorld.dispatch(m_lastMouseData);
	}
	
	private function onRollOut(event : MouseEvent) : Void
	{
		m_lastMouseData.retrieveEventData(event);
		this.rollOut.dispatch(m_lastMouseData);
		
		if (releaseWithRollOut)
		{
			this.release.dispatch(m_lastMouseData);
			this.rightRelease.dispatch(m_lastMouseData);
			this.scrollRelease.dispatch(m_lastMouseData);
		}
		
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
		this.rightClick.removeAll();
		this.rightPress.removeAll();
		this.rightRelease.removeAll();
		this.scrollClick.removeAll();
		this.scrollPress.removeAll();
		this.scrollRelease.removeAll();
		this.scroll.removeAll();
		this.move.removeAll();
		this.rollOver.removeAll();
		this.rollOut.removeAll();
		
		this.click = null;
		this.doubleClick = null;
		this.press = null;
		this.release = null;
		this.rightClick = null;
		this.rightPress = null;
		this.rightRelease = null;
		this.scrollClick = null;
		this.scrollPress = null;
		this.scrollRelease = null;
		this.scroll = null;
		this.move = null;
		this.rollOver = null;
		this.rollOut = null;
		
		this.objectRef = null;
	}
	
	//} ========================================
	
}