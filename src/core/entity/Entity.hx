package core.entity;
import core.component.Component;
import core.module.Module;
import core.module.ModuleManager;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;

/**
 * ...
 * @author Breakyt
 */
class Entity 
{
	
	public var name : String;
	
	private var m_components : Map<String, Component>;
	
	@:allow(core.Application)
	private var compAdded : Signal1<Entity>;
	
	@:allow(core.Application)
	private var compRemoved : Signal1<Entity>;

	public function new(name : String) 
	{
		this.name = name;
		m_components = new Map();
		compAdded = new Signal1<Entity>();
		compRemoved = new Signal1<Entity>();
	}
	
	public function add(comp : Component, eraseOld : Bool = false) : Void
	{
		var compTypeName : String = Type.getClassName(Type.getClass(comp));
		
		if (m_components.exists(compTypeName) && !eraseOld)
			trace("Can't add the component : " + compTypeName + " because this entity : " + this.name + " has already one");
		else
		{
			m_components.set(compTypeName , comp);
			compAdded.dispatch(this);
		}
	}
	
	public function remove(comp : Component) : Void
	{
		var compTypeName : String = Type.getClassName(Type.getClass(comp));
		m_components.remove(compTypeName);
		compRemoved.dispatch(this);
	}
	
	@:allow(core.module.ModuleManager)
	@:allow(core.module.Module)
	private function getComponentsTypesNames() : Array<String>
	{
		var result : Array<String> = [];
		
		for (key in m_components.keys())
			result.push(key);
			
		return result;
	}
	
	public function getComponent(type : Class<Dynamic>) : Component
	{
		for (component in m_components)
		{
			if (Type.getClass(component) == type)
				return component;
		}
		
		return null;
	}
	
	public function getComponentByTypeName(typeName : String) : Component
	{
		return m_components.get(typeName);
	}
	
	public function getComponentNumber() : Int
	{
		return Lambda.count(m_components);
	}
	
}