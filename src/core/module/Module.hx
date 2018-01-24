package core.module;
import core.component.Component;
import core.component.ComponentGroup;
import core.entity.Entity;
import haxe.Constraints.Constructible;
import haxe.Template;
import tools.Compare;

/**
 * Manage a collection of Componant
 * @author Breakyt
 */

class Module<T : ComponentGroup>
{
	private var m_compGroups : Array<T>;
	
	public var priority(default, null) : Int; 
	
	private var m_groupClass : Class<T>;
	
	public function new(type : Class<T>)
	{
		m_compGroups = [];
		priority = -1;		
		m_groupClass = type;
	}
	
	public function update(delta : Float) : Void
	{
		trace("Please override this module update() => " + Type.getClass(this)); 
	}
	
	@:allow(core.module.ModuleManager)
	private function isEntityAlreadyAddedOnAgroup(e : Entity) : Bool
	{
		for (group in m_compGroups)
		{
			if (group.entityRef == e)
				return true;
		}
		return false;
	}
	
	@:allow(core.module.ModuleManager)
	private function removeGroupByEntity(e : Entity) : Void
	{
		for (group in m_compGroups)
		{
			if (group.entityRef == e)
			{
				this.removeCompGroup(group);
				return;
			}
		}
	}
	
	@:allow(core.module.ModuleManager)
	private function removeGroupOnEntityComponentRemoved(e : Entity) : Void
	{
		for (group in m_compGroups)
		{
			if (group.entityRef == e)
			{
				
				var entityComponentsNames : Array<String> = e.getComponentsTypesNames();
				var groupComponentsNames : Array<String> = group.getTypes();
				
				if (groupComponentsNames.length > entityComponentsNames.length)
				{
					this.removeCompGroup(group);
					return;
				}
				else if (!Compare.allDataExist(groupComponentsNames, entityComponentsNames))
				{
					this.removeCompGroup(group);
					return;	
				}
			}
		}
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
		m_compGroups.push(group);
		onCompGroupAdded(group);
	}
	
	@:allow(core.module.ModuleManager)
	private function release() : Void
	{
		while (m_compGroups.length != 0)
			removeCompGroup(m_compGroups[0]);
	}
	
	private function removeCompGroup(group : T) : Void
	{
		m_compGroups.remove(group);
		onCompGroupRemove(group);
		group.delete();
	}
	
	private function onCompGroupAdded(group : T) : Void
	{

	}
	
	private function onCompGroupRemove(group : T) : Void
	{

	}
	
	
	
}