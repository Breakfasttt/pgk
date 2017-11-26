package input.mouseBehaviour;
import input.MouseSignals;

/**
 * ...
 * @author Breakyt
 */
class MouseBehaviour 
{
	/**
	 * Name of the behaviour
	 */
	public var name : String;
	
	/**
	 * the signals manager
	 */
	private var m_signals : MouseSignals;
	
	public function new(name : String, mouseSignals : MouseSignals) 
	{
		m_signals = mouseSignals;
	}
	
}