package core.entity;
import core.component.Component;
import core.module.ModuleManager;
import msignal.Signal.Signal0;

/**
 * ...
 * @author Breakyt
 */
class Entity 
{
	
	public var name : String;
	
	private var m_components : Map<String, Component>;
	
	@:allow(core.Application)
	private var compAdded : Signal0;
	
	@:allow(core.Application)
	private var compRemove : Signal0;

	public function new(name : String) 
	{
		this.name = name;
		m_components = new Map();
		compAdded = new Signal0();
		compRemove = new Signal0();
	}
	
	public function add(comp : Component, eraseOld : Bool = false) : Void
	{
		var compTypeName : String = Type.getClassName(Type.getClass(comp));
		
		if (m_components.exists(compTypeName) && !eraseOld)
			trace("Can't add the component : " + compTypeName + " because this entity : " + this.name + " has already one");
		else
			m_components.set(compTypeName ,comp);
	}
	
	@:allow(core.module.ModuleManager)
	private function getComponentsTypesNames() : Array<String>
	{
		var result : Array<String> = [];
		
		for (key in m_components.keys())
			result.push(key);
			
		return result;
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