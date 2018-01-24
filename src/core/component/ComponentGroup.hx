package core.component;
import core.entity.Entity;
import core.module.ModuleManager;

/**
 * ...
 * @author Breakyt
 */
class ComponentGroup 
{	
	public var entityRef(default, null) : Entity;
	
	private var m_mappingFieldWithType : Map<String, String>;
	
	public function new() 
	{
		m_mappingFieldWithType = new Map();
	}
	
	public function init(entity : Entity) : Void
	{
		this.entityRef = entity;
	}
	
	@:allow(core.module.ModuleManager)
	private function addType(type : Class<Component>, field : String) : Void
	{		
		var typeName : String = Type.getClassName(type);
		if(!m_mappingFieldWithType.exists(typeName))
			m_mappingFieldWithType.set(typeName, field);
	}
	
	@:allow(core.module.ModuleManager)
	private function getTypes() : Array<String>
	{
		var arr : Array<String> = [];
		
		for (key in m_mappingFieldWithType.keys())
			arr.push(key);
		
		return arr;
	}
	
	@:allow(core.module.ModuleManager)
	private function setFieldByType(typeName : String, obj : Component) : Bool
	{
		try
		{
			var field : String = m_mappingFieldWithType.get(typeName);
			Reflect.setProperty(this, field, obj);
		}
		catch (e : Dynamic)
		{
			return false;
		}
		
		return true;
	}
	
	/**
	 * Safe delete, Don't override it. 
	 * Override customDelete
	 */
	public function delete() : Void
	{
		this.entityRef = null;
		customDelete();
	}
	
	/**
	 * Override it on sub Class
	 */
	public function customDelete() : Void
	{
		
	}
	
}