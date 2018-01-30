package tools.time;
import msignal.Signal.Signal1;
import openfl.display.DisplayObject;
import openfl.events.Event;

/**
 * ...
 * @author Breakyt
 */
class FrameTicker 
{

	public var object(default, null) : DisplayObject;
	
	public var tick(default, null) : Signal1<Float>;
	
	private var m_startTime : Float;
	private var m_lastTime : Float;
	
	private var m_now : Float;
	
	public var elapsedSinceStart(default, null) : Float;
	public var lastDelta(default, null) : Float; // in ms
	
	public function new(objet : DisplayObject) 
	{
		this.object = objet;
		this.tick = new Signal1<Float>();
	}
	
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
	
	private function onEnterFrame(event : Event) : Void
	{
		m_now = Date.now().getTime();
		elapsedSinceStart = m_now - m_startTime;
		lastDelta = m_now - m_lastTime;
		m_lastTime = m_now;
		this.tick.dispatch(lastDelta);
	}
	
	public function stop() : Void
	{
		if (object != null)
			object.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
}