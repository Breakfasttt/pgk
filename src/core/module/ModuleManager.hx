package core.module;
import core.component.Component;
import core.component.ComponentGroup;
import core.entity.Entity;

/**
 * ...
 * @author Breakyt
 */
class ModuleManager 
{

	private var m_modules : Array<Module<ComponentGroup>>;
	
	public function new() 
	{
		m_modules = new Array();
	}
	
	public function update(dTime : Float)
	{
		for (mod in m_modules)
			mod.update(dTime);
	}
	
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
	
	@:allow(core.Application)
	private function removeModule(module : Module<ComponentGroup>) : Bool
	{
		if (!Lambda.has(m_modules, module))
			return false;
			
		module.release();	
		m_modules.remove(module);
		return true;
	}
	
	public function getModule<T>(modType : Class<T>) : T
	{
		for (mod in m_modules)
		{
			if ( Std.is(mod, modType) )
				return cast mod;
		}
		
		return null;	
	}
	
	private function sortModules(modA : Module<ComponentGroup>, modB : Module<ComponentGroup>) : Int
	{
		if (modA.priority < modB.priority)
			return 1;
		else if (modA.priority > modB.priority)
			return -1;
		else
			return 0;
	}
	
	public function createGroupForModuleIfEntityMatching(entity : Entity, module : Module<ComponentGroup>)
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
	
	public function checkAllModuleMatching(entity : Entity) : Void
	{
		if (entity.getComponentNumber() == 0)
			return;
		
		for (mod in m_modules)
			createGroupForModuleIfEntityMatching(entity, mod);
	}
	
	public function checkModuleOnEntityRemoved(e : Entity) : Void
	{
		for (mod in m_modules)
			mod.removeGroupByEntity(e);
	}
	
	public function checkModuleOnEntityComponentRemoved(e : Entity) : Void
	{
		for (mod in m_modules)
			mod.removeGroupOnEntityComponentRemoved(e);
	}
}