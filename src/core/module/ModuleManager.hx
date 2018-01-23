package core.module;
import core.componant.ComponantGroup;
import core.entity.Entity;

/**
 * ...
 * @author Breakyt
 */
class ModuleManager 
{

	private var m_modules : Array<Module<ComponantGroup>>;
	
	public function new() 
	{
		m_modules = new Array();
	}
	
	public function update(dTime : Float)
	{
		for (mod in m_modules)
			mod.update(dTime);
	}
	
	public function addModule(module : Module<ComponantGroup>, priority : Int = -1) : Void
	{
		module.setPriority(priority);
		m_modules.push(module);
		m_modules.sort(sortModules);
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
	
	private function sortModules(modA : Module<ComponantGroup>, modB : Module<ComponantGroup>) : Int
	{
		if (modA.priority < modB.priority)
			return 1;
		else if (modA.priority > modB.priority)
			return -1;
		else
			return 0;
	}
	
	public function createGroupForModuleIfEntityMatching(entity : Entity) : Void
	{
		if (entity.getComponentNumber() == 0)
			return;
		
		var entityCompNames : Array<String> =  entity.getComponantsTypesNames();
		
		var compGroupClassFields : Array<String> = []; 
		
		
		var ok : Bool  = true;
		
		for (mod in m_modules)
		{
			ok = true;		
			compGroupClassFields = Type.getClassFields(mod.getCompGroupType());
			compGroupClassFields.remove("entityRef");
			
			if (compGroupClassFields.length == 0)
				continue;
			
			if (compGroupClassFields.length != entityCompNames.length)
				continue;
				
			for (field in compGroupClassFields)
			{
				if (Lambda.has(entityCompNames, field))
					continue;
				else
				{
					ok = false;
					break;
				}
			}
			
			if (ok)
			{
				var compGroup : ComponantGroup = Type.createInstance(mod.getCompGroupType(), [entity]);
				for (field in compGroupClassFields)
					Reflect.setField(compGroup, field, entity.getComponantByTypeName(field));
					
				mod.addCompGroup(compGroup);
				
			}
			
		}
	}	
}