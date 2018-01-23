package core.entity;
import core.componant.Componant;
import msignal.Signal.Signal0;

/**
 * ...
 * @author Breakyt
 */
class Entity 
{
	
	public var name : String;
	
	private var m_componants : Map<String, Componant>;
	
	@:allow(core.Application)
	private var compAdded : Signal0;
	
	@:allow(core.Application)
	private var compRemove : Signal0;

	public function new(name : String) 
	{
		this.name = name;
		m_componants = new Map();
		compAdded = new Signal0();
		compRemove = new Signal0();
	}
	
	public function add(comp : Componant, eraseOld : Bool = false) : Void
	{
		var compTypeName : String = Type.getClassName(Type.getClass(comp));
		
		if (m_componants.exists(compTypeName) && !eraseOld)
			trace("Can't add the component : " + compTypeName + " because this entity : " + this.name + " has already one");
		else
			m_componants.set(compTypeName ,comp);
	}
	
	public function getComponantsTypesNames() : Array<String>
	{
		var result : Array<String> = [];
		
		for (key in m_componants.keys())
			result.push(key);
			
		return result;
	}
	
	public function getComponantByTypeName(typeName : String) : Componant
	{
		return m_componants.get(typeName);
	}
	
	public function getComponentNumber() : Int
	{
		return Lambda.count(m_componants);
	}
	
}