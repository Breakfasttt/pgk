package core.module;
import core.componant.Componant;
import core.componant.ComponantGroup;

/**
 * Manage a collection of Componant
 * @author Breakyt
 */
class Module<T : ComponantGroup>
{
	private var m_componants : Array<T>;
	
	public var priority(default, null) : Int; 
	
	private var m_groupTemplate(default, null) : T;
	
	public function new()
	{
		m_componants = [];
		priority = -1;
		m_groupTemplate = null;
	}
	
	public function update(delta : Float) : Void
	{
		trace("Please override this module update() => " + Type.getClass(this)); 
	}
	
	@:allow(core.module.ModuleManager)
	private function setPriority(priority : Int) : Void
	{
		this.priority = priority;
	}
	
	@:allow(core.module.ModuleManager)
	private function getCompGroupType() : Class<Dynamic>
	{
		return Type.getClass(m_groupTemplate);
	}
	
	public function addCompGroup(group : T) : Void
	{
		m_componants.push(group);
	}
	
	
	
	
	
}