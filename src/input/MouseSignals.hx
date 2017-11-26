package input;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import openfl.display.InteractiveObject;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Breakyt
 */
class MouseSignals 
{

	/**
	 * The interactive object who listen mouse signal
	 */
	public var object(default, null) : InteractiveObject;
	
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
	public var click : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when a double left-click (press and release action *2) happen.
	 * leftClickEnable must be set as true
	 */
	public var doubleClick : Signal1<MouseData>;

	/**
	 * Signal dispatch when a left-press happen (left mouse button hold down)
	 * leftClickEnable must be set as true
	 */
	public var press : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when a left-release happen (left mouse button just up/release)
	 * leftClickEnable must be set as true
	 */
	public var release : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when a right-click happen(press and release action).
	 * rightClickEnable must be set as true
	 */
	public var rightClick: Signal1<MouseData>;
	
	/**
	 * Signal dispatch when a right-press happen (right mouse button hold down)
	 * rightClickEnable must be set as true
	 */
	public var rightPress : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when a right-release happen (right mouse button just up/release)
	 * rightClickEnable must be set as true
	 */
	public var rightRelease : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when a mouse scroll button click happen (press and release action)
	 * scrollEnable must be set as true
	 */
	public var scrollClick : Signal1<MouseData>;
	
	
	/**
	 * Signal dispatch when a mouse scroll button-press happen (scroll mouse button hold down)
	 * scrollEnable must be set as true
	 */
	public var scrollPress : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when a mouse scroll button-release happen (scroll mouse button just up/release)
	 * scrollEnable must be set as true
	 */
	public var scrollRelease : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when mouse scroll
	 * scrollEnable must be set as true
	 */
	public var scroll : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when mouse move only on this.object
	 * moveEnable must be set as true
	 */
	public var localMove : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when mouse move anywhere on the stage
	 * moveEnable must be set as true
	 */
	public var worldMove : Signal1<MouseData>;
	
	
	/**
	 * Signal dispatch when roll over the interactive object
	 */
	public var rollOver : Signal1<MouseData>;
	
	
	/**
	 * Signal dispatch when roll out the interactive object 
	 */
	public var rollOut : Signal1<MouseData>;
	
	/**
	 * Signal dispatch when mouse leave the stage
	 */
	public var leaveWorld : Signal1<MouseData>;
	
	
	/**
	 * An help variable send by all signal. (read only)
	 */
	private var m_lastMouseData : MouseData;
	
	public function new(interactiveObject : InteractiveObject, leftClick : Bool = true, rightClick :  Bool = false, scroll : Bool = false, localMove : Bool = false, worldMove : Bool = false) 
	{
		this.object = interactiveObject;
		
		this.m_lastMouseData = new MouseData();
		
		this.click = new Signal1<MouseData>();
		this.doubleClick = new Signal1<MouseData>();
		this.press = new Signal1<MouseData>();
		this.release = new Signal1<MouseData>();
		this.rightClick = new Signal1<MouseData>();
		this.rightPress = new Signal1<MouseData>();
		this.rightRelease = new Signal1<MouseData>();
		this.scrollClick = new Signal1<MouseData>();
		this.scrollPress = new Signal1<MouseData>();
		this.scrollRelease = new Signal1<MouseData>();
		this.scroll = new Signal1<MouseData>();
		this.localMove = new Signal1<MouseData>();
		this.worldMove = new Signal1<MouseData>();
		this.rollOver = new Signal1<MouseData>();
		this.rollOut = new Signal1<MouseData>();
		
		this.leaveWorld = new Signal1 <MouseData>();
		
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
		if (this.object == null)
			return;
			
		attachWorldListener();	
			
		if(!object.hasEventListener(MouseEvent.ROLL_OUT))	
			object.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
		if(!object.hasEventListener(MouseEvent.ROLL_OVER))	
			object.addEventListener(MouseEvent.ROLL_OVER, onRollOver);			
			
		if (this.leftClickEnable)
		{
			if(!object.hasEventListener(MouseEvent.CLICK))	
				object.addEventListener(MouseEvent.CLICK, onClick);
			
			if(!object.hasEventListener(MouseEvent.DOUBLE_CLICK))	
				object.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
				
			if(!object.hasEventListener(MouseEvent.MOUSE_DOWN))	
				object.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			if(!releaseOutsideObject && !object.hasEventListener(MouseEvent.MOUSE_UP))	
				object.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		if (this.scrollEnable)
		{
			if(!object.hasEventListener(MouseEvent.MIDDLE_CLICK))	
				object.addEventListener(MouseEvent.MIDDLE_CLICK, onMiddleClick);
			
			if(!object.hasEventListener(MouseEvent.MOUSE_WHEEL))	
				object.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
			if(!object.hasEventListener(MouseEvent.MIDDLE_MOUSE_DOWN))	
				object.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
			
			if(!releaseOutsideObject && !object.hasEventListener(MouseEvent.MIDDLE_MOUSE_UP))	
				object.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);		
		}
		
		if (this.rightClickEnable)
		{
			if(!object.hasEventListener(MouseEvent.RIGHT_CLICK))	
				object.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
				
			if(!object.hasEventListener(MouseEvent.RIGHT_MOUSE_DOWN))
				object.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
				
			if(!releaseOutsideObject && !object.hasEventListener(MouseEvent.RIGHT_MOUSE_UP))	
				object.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
		}
		
		if(this.localMoveEnable && !object.hasEventListener(MouseEvent.MOUSE_MOVE))	
			object.addEventListener(MouseEvent.MOUSE_MOVE, onLocalMouseMove);
	}
	
	/**
	 * add event/mousevent  who depend of the stage
	 */
	private function attachWorldListener() : Void
	{
		if (this.object == null)
			return;
		else if (this.object.stage == null)
		{
			if(!this.object.hasEventListener(Event.ADDED_TO_STAGE))
				this.object.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				
			return;
		}
		
		object.stage.addEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);
		object.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
		
		if(!this.object.hasEventListener(Event.REMOVED_FROM_STAGE))
			this.object.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		
		if (this.worldMoveEnable)
			object.stage.addEventListener(MouseEvent.MOUSE_MOVE, onWorldMouseMove);
			
		if (releaseOutsideObject)
		{
			if (this.rightClickEnable && !object.hasEventListener(MouseEvent.RIGHT_MOUSE_UP))
				object.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
				
			if (this.scrollEnable && !object.hasEventListener(MouseEvent.MIDDLE_MOUSE_UP))	
				object.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);	
				
			if (this.leftClickEnable && !object.hasEventListener(MouseEvent.MOUSE_UP))	
				object.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
	}
	
	/**
	 * remove all MouseEvent Listener
	 */
	private function removeListeners() : Void
	{
		if (this.object == null)
			return;
			
		removeWorldListener();	
			
		if(object.hasEventListener(MouseEvent.CLICK))	
			object.removeEventListener(MouseEvent.CLICK, onClick);
		
		if(object.hasEventListener(MouseEvent.DOUBLE_CLICK))	
			object.removeEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		
		if(object.hasEventListener(MouseEvent.MOUSE_DOWN))	
			object.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		
		if(object.hasEventListener(MouseEvent.MOUSE_UP))	
			object.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
		if(object.hasEventListener(MouseEvent.MIDDLE_CLICK))	
			object.removeEventListener(MouseEvent.MIDDLE_CLICK, onMiddleClick);
		
		if(object.hasEventListener(MouseEvent.MIDDLE_MOUSE_DOWN))	
			object.removeEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
		
		if(object.hasEventListener(MouseEvent.MIDDLE_MOUSE_UP))	
			object.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);
			
		if(object.hasEventListener(MouseEvent.MOUSE_WHEEL))	
			object.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
		if(object.hasEventListener(MouseEvent.RIGHT_CLICK))	
			object.removeEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			
		if(object.hasEventListener(MouseEvent.RIGHT_MOUSE_DOWN))	
			object.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
			
		if(object.hasEventListener(MouseEvent.RIGHT_MOUSE_UP))	
			object.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
			
		if(object.hasEventListener(MouseEvent.MOUSE_MOVE))	
			object.removeEventListener(MouseEvent.MOUSE_MOVE, onLocalMouseMove);
			
		if(object.hasEventListener(MouseEvent.RELEASE_OUTSIDE))	
			object.removeEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);			
			
		if(object.hasEventListener(MouseEvent.ROLL_OUT))	
			object.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
		if(object.hasEventListener(MouseEvent.ROLL_OVER))	
			object.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
	}
	
	/**
	 * remove event listener who depend of the stage
	 */
	private function removeWorldListener() : Void
	{
		if (this.object == null)
			return;
		else if (this.object.stage == null)
			return;
			
		object.stage.removeEventListener(MouseEvent.RELEASE_OUTSIDE, onReleaseOutside);
		object.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
		object.stage.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
		object.stage.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);	
		object.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	/**
	 * refresh listener when the object is added to the stage.
	 * Usefull for stage event listener like Release_outside
	 * @param	event
	 */
	private function onAddedToStage(event : Event)
	{
		this.object.stage.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		this.removeListeners();
		this.attachListeners();
	}
	
	private function onRemoveFromStage(event : Event)
	{
		this.object.stage.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		this.removeListeners();
		this.attachListeners();
	}
	
	private function retrieveEssentialMouseData(event : MouseEvent) : Void
	{
		m_lastMouseData.target = this.object;
		m_lastMouseData.altModifier = event.altKey;
		m_lastMouseData.ctrlModifier = event.ctrlKey;
		m_lastMouseData.deltaScroll = event.delta;
		m_lastMouseData.localPosition.setTo(event.localX, event.localY);
		m_lastMouseData.worldPosition.setTo(event.stageX, event.stageY);
	}
	
	//{ ==== Mouse Left button event handling ====
	
	private function onClick(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.click.dispatch(m_lastMouseData);
	}
	
	private function onDoubleClick(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.doubleClick.dispatch(m_lastMouseData);
	}
	
	private function onMouseDown(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.press.dispatch(m_lastMouseData);
	}
	
	private function onMouseUp(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.release.dispatch(m_lastMouseData);
	}
	
	//} ========================================
	
	//{ ==== Mouse middle button  event handling  ====
	
	private function onMiddleMouseDown(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.scrollPress.dispatch(m_lastMouseData);
	}
	
	private function onMiddleMouseUp(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.scrollRelease.dispatch(m_lastMouseData);
	}
	
	private function onMiddleClick(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.scrollClick.dispatch(m_lastMouseData);
	}
	
	private function onMouseWheel(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.scroll.dispatch(m_lastMouseData);
	}
	
	//} ========================================
	
	//{ ==== Mouse right button  event handling  ====
	
	private function onRightClick(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.rightClick.dispatch(m_lastMouseData);
	}
	
	private function onRightMouseDown(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.rightPress.dispatch(m_lastMouseData);
	}
	
	private function onRightMouseUp(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.rightRelease.dispatch(m_lastMouseData);
	}
	
	//} ========================================
	
	
	//{ == mouse move  event handling  ==
	
	private function onLocalMouseMove(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.localMove.dispatch(m_lastMouseData);
	}
	
	private function onWorldMouseMove(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
		this.worldMove.dispatch(m_lastMouseData);
		
		if (object.stage != null)
		{
			if (m_lastMouseData.worldPosition.x < 0.0 || m_lastMouseData.worldPosition.x > object.stage.stageWidth
				||  m_lastMouseData.worldPosition.y < 0.0 || m_lastMouseData.worldPosition.y > object.stage.stageHeight)
			{
				onMouseLeaveStage(null);
			}
		}
	}
	
	//} ========================================
	
	
	//{ == generic mouse  event handling  ==
	
	private function onReleaseOutside(event : MouseEvent) : Void
	{
		//works only with left click
		trace("test");
		this.retrieveEssentialMouseData(event);
		
		this.release.dispatch(m_lastMouseData);
		//this.rightRelease.dispatch(m_lastMouseData);
		//this.scrollRelease.dispatch(m_lastMouseData);
	}
	
	private function onMouseLeaveStage(event : Event) : Void
	{
		trace("test 2 ");
		m_lastMouseData.altModifier = false;
		m_lastMouseData.ctrlModifier = false;
		m_lastMouseData.deltaScroll = 0;
		m_lastMouseData.localPosition.setTo(0, 0);
		m_lastMouseData.target = null;
		m_lastMouseData.worldPosition.setTo(0, 0);
		this.leaveWorld.dispatch(m_lastMouseData);
	}
	
	private function onRollOut(event : MouseEvent) : Void
	{
		this.retrieveEssentialMouseData(event);
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
		this.retrieveEssentialMouseData(event);
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
		if (this.object == null)
			return;
			
		this.object.mouseEnabled = enable;
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
		this.localMove.removeAll();
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
		this.localMove = null;
		this.rollOver = null;
		this.rollOut = null;
		
		this.object = null;
	}
	
	//} ========================================
	
}