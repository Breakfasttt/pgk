package core.module;
import core.componant.Componant;

/**
 * Manage a collection of Componant
 * @author Breakyt
 */
class Module<T:Componant>
{
	public var name : String;
	
	public var componants : Array<T>;
	
	private var m_type : T;
	
	public function new(name : String)
	{
		
	}
	
	public function update(delta : Float) : Void
	{
		
	}
	
	public function isCompatible(componant : Class<Dynamic>) : Bool
	{
		return Type.getClass(m_type) == componant;
	}
}