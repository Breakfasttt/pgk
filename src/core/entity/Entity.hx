package core.entity;
import core.component.Component;
import core.module.Module;
import core.module.ModuleManager;
import msignal.Signal.Signal1;

/**
 * An Entity represent a GameObject who have some property called Component.
 * An entity can be added to the Application. All component on the entity will be update/modified by 
 * specific module depending of there Type. (Using a class helper name ComponentGroup)
 * @author Breakyt
 */
class Entity 
{
	
	/**
	 * The name of the entity
	 */
	@:allow(core.Application)
	public var name(default,null) : String;
	
	/**
	 * All components on the entity, bind with there Type to create ComponentGroup on ModuleManager
	 */
	private var m_components : Map<String, Component>;
	
	/**
	 * A signal dispatch when a new component is added
	 */
	@:allow(core.Application)
	private var compAdded : Signal1<Entity>;
	
	/**
	 * A signal dispatch when a component is removed
	 */
	@:allow(core.Application)
	private var compRemoved : Signal1<Entity>;

	/**
	 * New entity. Name is not necessary unique, but it's better :)
	 * @param	name
	 */
	public function new(name : String) 
	{
		this.name = name;
		m_components = new Map();
		compAdded = new Signal1<Entity>();
		compRemoved = new Signal1<Entity>();
	}
	
	/**
	 * Add a component to the entity. Only one component by type is allowed. 
	 * When you add a component who extends one or more Type, all Super Type is added with 'comp' as data. (except Composant type)
	 * Exemple : myClassA extends myClassB extends myClassC extends Composant will add on entity :
	 * 'myClassA' <=> 'comp'
	 * 'myClassB' <=> 'comp'
	 * 'myClassC' <=> 'comp'
	 * Usefull for Group creation on ModuleManager
	 * @param comp
	 */
	public function add(comp : Component) : Void
	{
		if (comp == null)
		{
			trace("Can't add null component to entity " + this.name + ". Operation aborted");
			return;
		}
		
		var compType : Class<Dynamic> = Type.getClass(comp);
		var compTypeName : String = null;
		
		var added : Bool = false;
		while (compType != null)
		{
			compTypeName = Type.getClassName(compType);
			if (m_components.exists(compTypeName))
				continue;
			else if(compType != Component) // a tester
			{
				added = true;
				m_components.set(compTypeName , comp);
			}
			
			compType = Type.getSuperClass(compType);
		}
		
		if(added)
			compAdded.dispatch(this);
		else
			trace("Can't add the component : " + comp + " because this entity : " + this.name + " has already one");
	}
	
	/**
	 * Remove a component from an entity (Remove all Type binded with this compo)
	 * @param	comp
	 */
	public function remove(comp : Component) : Void
	{
		var compTypeName : String = Type.getClassName(Type.getClass(comp));
		m_components.remove(compTypeName);
		
		var toRemove : Array<String> = [];
		for (key in m_components.keys())
		{
			if (m_components.get(key) == comp)
				toRemove.push(key);
		}
		
		for (compKey in toRemove)
			m_components.remove(compKey);
		
		if(toRemove.length > 0)
			compRemoved.dispatch(this);
	}
	
	/**
	 * Remove a component by his type
	 * @param	comp
	 */
	public function removeByType(type : Class<Dynamic>) : Void
	{
		if (type == null)
			return;
		
		var comp : Component = this.getComponent(type);
		if (comp == null)
			return;
			
		this.remove(comp);
	}
	
	/**
	 * Get all type of component in this entity. Usefull for ComponentGroup creation.
	 * Used by ModuleManager and Module
	 */
	@:allow(core.module.ModuleManager)
	@:allow(core.module.Module)
	private function getComponentsTypesNames() : Array<String>
	{
		var result : Array<String> = [];
		
		for (key in m_components.keys())
			result.push(key);
			
		return result;
	}
	
	/**
	 * Get a component of the entity by his Type
	 * @param	type
	 * @return
	 */
	public function getComponent(type : Class<Dynamic>) : Component
	{
		for (component in m_components)
		{
			if (Type.getClass(component) == type)
				return component;
		}
		
		return null;
	}
	
	/**
	 * Get component by his type name
	 * @param	typeName
	 * @return
	 */
	public function getComponentByTypeName(typeName : String) : Component
	{
		return m_components.get(typeName);
	}
	
	/**
	 * Get the number of component contained in this entity
	 * @return
	 */
	public function getComponentNumber() : Int
	{
		return Lambda.count(m_components);
	}
	
}