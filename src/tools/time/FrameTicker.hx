package tools.time;
import msignal.Signal.Signal1;
import openfl.display.DisplayObject;
import openfl.events.Event;

/**
 * A Class to manage "EnterFrame" event
 * @author Breakyt
 */
class FrameTicker 
{

	/**
	 * the object who listen the enter frame event
	 */
	public var object(default, null) : DisplayObject;
	
	/**
	 * Signal dispatch when event "enter frame" is detect
	 */
	public var tick(default, null) : Signal1<Float>;
	
	/**
	 * tools variable to calcul delta time
	 */
	private var m_startTime : Float;
	
	/**
	 * tools variable to calcul delta time
	 */
	private var m_lastTime : Float;
	
	/**
	 * tools variable to calcul delta time
	 */
	private var m_now : Float;
	
	/**
	 * Time elapsed since start() function is call.
	 */
	public var elapsedSinceStart(default, null) : Float;
	
	/**
	 * the last delta time calculated between two enter frame event
	 * set to 0 at start
	 */
	public var lastDelta(default, null) : Float; // in ms
	
	/**
	 * A Class to manage "EnterFrame" event. Usefull for "update"
	 * @param	objet : the display object who listen the enter frame event
	 */
	public function new(objet : DisplayObject) 
	{
		this.object = objet;
		this.tick = new Signal1<Float>();
	}
	
	/**
	 * Start the frame ticker. i.e. Add the "enter frame" listener to this.object
	 */
	public function start() : Void
	{
		if (object != null)
		{
			object.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			m_now = Date.now().getTime();
			m_startTime = m_now;
			m_lastTime = m_startTime;
			elapsedSinceStart = 0.0;
			lastDelta = 0.0;
		}
	}
	
	/**
	 * callback of the enter frame event listener
	 * @param	event
	 */
	private function onEnterFrame(event : Event) : Void
	{
		m_now = Date.now().getTime();
		elapsedSinceStart = m_now - m_startTime;
		lastDelta = m_now - m_lastTime;
		m_lastTime = m_now;
		this.tick.dispatch(lastDelta);
	}
	
	/**
	 * Stop the frame ticker. I.E. remove the "enter frame" listener from this.object
	 */
	public function stop() : Void
	{
		if (object != null)
			object.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
}