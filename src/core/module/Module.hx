package core.module;
import core.component.Component;
import core.component.ComponentGroup;
import haxe.Constraints.Constructible;
import haxe.Template;

/**
 * Manage a collection of Componant
 * @author Breakyt
 */

class Module<T : ComponentGroup>
{
	private var m_componants : Array<T>;
	
	public var priority(default, null) : Int; 
	
	private var m_groupClass : Class<T>;
	
	public function new(type : Class<T>)
	{
		m_componants = [];
		priority = -1;		
		m_groupClass = type;
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
	private function getCompGroupType() : Class<T>
	{
		return m_groupClass;
	}
	
	@:allow(core.module.ModuleManager)
	private function addCompGroup(group : T) : Void
	{
		m_componants.push(group);
		onCompGroupAdded(group);
	}
	
	private function onCompGroupAdded(group : T) : Void
	{

	}
	
	
	
}