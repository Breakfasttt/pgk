package input.behaviour;
import core.entity.Entity;
import input.IPointerSignals;
import input.WorldSignal;
import input.pointerImpl.BasicMouseSignals;

/**
 * Extends Pointer behaviour to make specific pointer comportement like drag'n'drop
 * @author Breakyt
 */
class PointerBehaviour 
{
	/**
	 * The world Pointer Signal of necessary.
	 */
	private var m_worldSignals : WorldSignal;
	
	/**
	 * A Pointer signal manager (see BasicMouseSignal for exemple)
	 */
	private var m_signals : IPointerSignals;
	
	/**
	 * Enable/disable this Behaviour (must be manage into herited behaviour)
	 * defaut = true;
	 */
	public var enable : Bool;
	
	/**
	 * @param	mouseSignals : A Pointer signal manager (see BasicMouseSignal for exemple)
	 * @param	worldSignals : The world pointer signals manager. If set to null, it's use the WorldSignal.self singleton
	 */
	public function new(mouseSignals : IPointerSignals, worldSignals : WorldSignal = null) 
	{
		m_signals = mouseSignals;
		this.enable = true;
		
		if (worldSignals == null)
			m_worldSignals = WorldSignal.self;
		else
			m_worldSignals = worldSignals;
		
	}
	
	public function delete() : Void
	{
		m_worldSignals = null;
		if (m_signals != null)
			m_signals.delete();

	}
	
}