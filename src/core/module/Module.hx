package core.module;
import core.component.Component;
import core.component.ComponentGroup;
import core.entity.Entity;
import haxe.Constraints.Constructible;
import haxe.Template;
import tools.Compare;

/**
 * Update/Modify/handle a collection of Componant name ComponentGroup.
 * One module manage One specific type of ComponentGroup
 * This class must be extends.
 * @author Breakyt
 */
class Module<T : ComponentGroup>
{
	/**
	 * All ComponentGroup added on this module
	 */
	private var m_compGroups : Array<T>;
	
	/**
	 * You can specify a priority to this module to update Component after/before other module
	 * A module with lower priority will be update first
	 */
	public var priority(default, null) : Int; 
	
	/**
	 * A tools parameters to save the type of ComponentGroup Manage by this system
	 */
	private var m_groupClass : Class<T>;
	
	/**
	 * You must specify the Type of ComponentGroup who manage a module.
	 * See test.module.ModuleTest for an exemple
	 * @param	type
	 */
	public function new(type : Class<T>)
	{
		m_compGroups = [];
		priority = -1;		
		m_groupClass = type;
	}
	
	/**
	 * Check if a ComponentGroup  who contains the entity in parameters exist in this module
	 * Usefull to manage ComponentGroup creation on ModuleManager
	 */
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
	
	/**
	 * Remove a ComponentGroup who contains the entity in parameters from this module
	 * Usefull to manage ComponentGroup creation on ModuleManager
	 */
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
	
	
	/**
	 * Check all component on the entity in parameters and his associed ComponentGroup in this module (if exist).
	 * If entity have not all the necessary component to complete the ComponentGroup. The Group is remove
	 * Usefull to manage ComponentGroup creation on ModuleManager
	 */
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
	
	/**
	 * Set the priority of the module
	 */
	@:allow(core.module.ModuleManager)
	private function setPriority(priority : Int) : Void
	{
		this.priority = priority;
	}
	
	/**
	 * Get the ComponentGroup type manage by this module
	 */
	@:allow(core.module.ModuleManager)
	private function getCompGroupType() : Class<T>
	{
		return m_groupClass;
	}
	
	/**
	 * Add a ComponentGroup to this module
	 */
	@:allow(core.module.ModuleManager)
	private function addCompGroup(group : T) : Void
	{
		m_compGroups.push(group);
		onCompGroupAdded(group);
	}
	
	/**
	 * Release the module and all of his ComponentGroup
	 */
	@:allow(core.module.ModuleManager)
	private function release() : Void
	{
		while (m_compGroups.length != 0)
			removeCompGroup(m_compGroups[0]);
	}
	
	/**
	 * Safe remove of a ComponentGroup
	 * @param	group
	 */
	private function removeCompGroup(group : T) : Void
	{
		m_compGroups.remove(group);
		onCompGroupRemove(group);
		group.delete();
	}
	
	/**
	 * Update function call by the application.
	 * Must be override
	 * @param	delta
	 */
	public function update(delta : Float) : Void
	{
		trace("Please override this module update() => " + Type.getClass(this)); 
	}	
	
	/**
	 * Call when a ComponentGroup is added to this module.
	 * Need To be override
	 * @param	group
	 */
	private function onCompGroupAdded(group : T) : Void
	{

	}
	
	/**
	 * Call when a ComponentGroup is removed to this module.
	 * Need To be override
	 * @param	group
	 */
	private function onCompGroupRemove(group : T) : Void
	{

	}
	
	
	
}