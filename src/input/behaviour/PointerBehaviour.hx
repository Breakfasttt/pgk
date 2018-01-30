package input.behaviour;
import core.entity.Entity;
import input.pointerImpl.MouseSignals;

/**
 * ...
 * @author Breakyt
 */
class PointerBehaviour 
{
	/**
	 * the signals manager
	 */
	private var m_signals : MouseSignals;
	
	public function new(mouseSignals : MouseSignals) 
	{
		m_signals = mouseSignals;
	}
	
}