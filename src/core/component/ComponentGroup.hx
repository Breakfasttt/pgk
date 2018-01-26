package core.component;
import core.entity.Entity;
import core.module.Module;
import core.module.ModuleManager;

/**
 * A ComponentGroup represents a bundle of Component of a same entity.
 * Usefull for auto-completion on a module.
 * 
 * A ComponentGroup is automaticly instancied by the Application when you add components on an Entity (who is added to the Application)
 * and only if a module who need this type of ComponentGroup exist in the Application.
 * 
 * This Class need to be Extends. Don't use it directly. See exemple on test.group.GroupTest To use it
 * 
 * See commentary on bindFieldType of this class for more information
 * 
 * @author Breakyt
 */
class ComponentGroup 
{	
	/**
	 * The entity who contains alls the component of this group
	 */
	public var entityRef(default, null) : Entity;
	
	/**
	 * A map to bind a ComponentGroup Field with his type. 
	 * Use by Module Manager when a Component Group is instancied
	 */
	private var m_mappingFieldWithType : Map<String, String>;
	
	/**
	 * Don't create a ComponentGroup Object directly.
	 * ComponentGroup need to be extends
	 */
	public function new() 
	{
		m_mappingFieldWithType = new Map();
	}
	
	/**
	 * Init the ComponentGroup at the creation on ModuleManager
	 */
	@:allow(core.module.ModuleManager)
	private function init(entity : Entity) : Void
	{
		this.entityRef = entity;
	}
	
	/**
	 * Bind a GroupComponent field to his type need to be call on new() when you extends this class 
	 * for each field. Field need to be public.
	 * 
	 * exemple : 
	 * 
	 * class MyGroup extends ComponentGroup
	 * {
	 * 		public var myComponent : MyComponentClass;
	 * 
	 * 		public function new() : Void
	 * 		{
	 *			super();
	 * 			this.addType(MyComponentClass, "myComponent");
	 *		}
	 * }
	 */
	@:allow(core.module.ModuleManager)
	private function bindFieldType(type : Class<Component>, field : String) : Void
	{		
		var typeName : String = Type.getClassName(type);
		if(!m_mappingFieldWithType.exists(typeName))
			m_mappingFieldWithType.set(typeName, field);
	}
	
	/**
	 * Access to binding Field<=>Class map
	 * Use by Module and ModuleManager
	 */
	@:allow(core.module.ModuleManager)
	@:allow(core.module.Module)
	private function getTypes() : Array<String>
	{
		var arr : Array<String> = [];
		
		for (key in m_mappingFieldWithType.keys())
			arr.push(key);
		
		return arr;
	}
	
	/**
	 * Set the specified field (if exist) by a component Object using the binding map.
	 * return false if fail (wrong type, field doesn't exist), true otherwise
	 */
	@:allow(core.module.ModuleManager)
	private function setFieldByType(typeName : String, obj : Component) : Bool
	{
		try
		{
			var field : String = m_mappingFieldWithType.get(typeName);
			
			if (field == null)
			{
				trace("Fail to set a group field with this type : " + typeName +" and object " + obj);
				return false;
			}
				
			Reflect.setProperty(this, field, obj);
		}
		catch (e : Dynamic)
		{
			trace("Fail to set a field with this type : " + typeName +" and object " + obj);
			trace("Error : " + e);
			return false;
		}
		
		return true;
	}
	
	/**
	 * Safe delete, Don't override it. 
	 * Override customDelete
	 * Module delete correctly a Component group. So don't delete a group by yourself
	 */
	@:allow(core.module.Module)
	private function delete() : Void
	{
		this.entityRef = null;
		customDelete();
	}
	
	/**
	 * Usefull to remove some reference or clean custom object.
	 * This function is call on delete() (call by Module class) after cleaning the entity reference
	 * Override it on sub Class if necessary
	 */
	private function customDelete() : Void
	{
		
	}
	
}