package core.module;
import core.component.Component;
import core.component.ComponentGroup;
import core.entity.Entity;
import tools.misc.Compare;

/**
 * A class who manage module creation and ComponentGroup creation when Entity/Component his added to Application/Entity
 * @author Breakyt
 */
class ModuleManager 
{

	/**
	 * Array contains all modules added to the Application
	 */
	private var m_modules : Array<Module<ComponentGroup>>;
	
	/**
	 * A class who manage module creation and ComponentGroup creation when Entity/Component his added to Application/Entity
	 */
	public function new() 
	{
		m_modules = new Array();
	}
	
	/**
	 * Update all module by there priority
	 * Call by Application
	 * @param	dTime
	 */
	@:allow(core.Application)
	private function update(dTime : Float)
	{
		for (mod in m_modules)
			mod.update(dTime);
	}
	
	/**
	 * Add a module with a priority to the manager
	 */
	@:allow(core.Application)
	private function addModule(module : Module<ComponentGroup>, priority : Int = -1) : Bool
	{
		if (Lambda.has(m_modules, module))
			return false;
		
		module.setPriority(priority);
		m_modules.push(module);
		m_modules.sort(sortModules);
		return true;
	}
	
	/**
	 * Remove a module to the manager
	 * Release the module by deleting all his Component Group
	 */
	@:allow(core.Application)
	private function removeModule(module : Module<ComponentGroup>) : Bool
	{
		if (!Lambda.has(m_modules, module))
			return false;
			
		module.release();	
		m_modules.remove(module);
		return true;
	}
	
	/**
	 * Get a module by his type
	 */
	public function getModule<T>(modType : Class<T>) : T
	{
		for (mod in m_modules)
		{
			if ( Std.is(mod, modType) )
				return cast mod;
		}
		
		return null;	
	}
	
	/**
	 * Tools function to sort module by there priority
	 * @param	modA
	 * @param	modB
	 * @return
	 */
	private function sortModules(modA : Module<ComponentGroup>, modB : Module<ComponentGroup>) : Int
	{
		if (modA.priority < modB.priority)
			return -1;
		else if (modA.priority > modB.priority)
			return 1;
		else
			return 0;
	}
	
	/**
	 * Create ComponentGroup  if the entity in parameters contains components matching with 
	 * The Type of ComponentGroup manage by the module in parameters.
	 */
	@:allow(core.Application)
	private function createGroupForModuleIfEntityMatching(entity : Entity, module : Module<ComponentGroup>)
	{
		if (entity.getComponentNumber() == 0)
			return;
			
		if (module.isEntityAlreadyAddedOnAgroup(entity))
			return;
			
		var entityCompNames : Array<String> =  entity.getComponentsTypesNames();
		var tempGroup : ComponentGroup = Type.createInstance(module.getCompGroupType(), []);
		var compGroupTypes : Array<String> = tempGroup.getTypes();
		
		if (compGroupTypes.length == 0)
			return;
		
		if (compGroupTypes.length > entityCompNames.length)
			return;
			
		if (!Compare.allDataExist(compGroupTypes, entityCompNames))
			return;
			
		var ok : Bool  = true;
		var tempComponent : Component = null;
		tempGroup.init(entity);
		for (type in compGroupTypes)
		{
			tempComponent = entity.getComponentByTypeName(type);
			if (!tempGroup.setFieldByType(type, tempComponent))
			{
				ok = false;
				break;
			}
		}
		
		if (ok)
			module.addCompGroup(tempGroup);		
	}
	
	/**
	 * A function who call createGroupForModuleIfEntityMatching() for each module
	 * if entity have 0 entity, the check is skipped
	 */
	@:allow(core.Application)
	private function checkAllModuleMatching(entity : Entity) : Void
	{
		if (entity.getComponentNumber() == 0)
			return;
		
		for (mod in m_modules)
			createGroupForModuleIfEntityMatching(entity, mod);
	}
	
	/**
	 * Remove ComponentGroup (associed with the entity in parameters) from modules
	 * call when a entity is removed from the Application
	 */
	@:allow(core.Application)
	private function checkModuleOnEntityRemoved(e : Entity) : Void
	{
		for (mod in m_modules)
			mod.removeGroupByEntity(e);
	}
	
	/**
	 * Remove ComponentGroup (associed with the entity in parameters) from modules 
	 * by checking  the "Components matching" between the entity and the ComponentGroup of each module
	 * call when a component is removed from an entity who exist in Application
	 */
	@:allow(core.Application)
	private function checkModuleOnEntityComponentRemoved(e : Entity) : Void
	{
		for (mod in m_modules)
			mod.removeGroupOnEntityComponentRemoved(e);
	}
}