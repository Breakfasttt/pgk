package input;
import input.data.PointerData;
import msignal.Signal.Signal1;
import openfl.display.InteractiveObject;


/**
 * @author Breakyt
 */
interface IPointerSignals 
{
	
	/**
	 * The interactive object who listen mouse signal
	 */
	public var objectRef(default, null) : InteractiveObject;
	
	/**
	 * Signal dispatch when pointer is pressed on the specified object
	 */
	public var press : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when pointer is released  on the specified object
	 */
	public var release : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when pointer move  on the specified object
	 */
	public var move : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when pointer roll over the specified object
	 */
	public var rollOver : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when pointer roll out the specified object
	 */
	public var rollOut : Signal1<PointerData>;
	
	/**
	 * Signal dispatch when pointer "click/tap" on the specified object
	 */
	public var click : Signal1<PointerData>;
	
}