package standard.components.input.utils;
import core.entity.Entity;
import input.behaviour.PointerBehaviour;
import standard.components.input.PointerBehavioursComponent;

/**
 * A abstract class to create Pointer behaviour for Entity
 * @author Breakyt
 */
class EntityPointerBehaviour 
{

	private var m_pointerBehaviour : PointerBehaviour;
	
	@:allow(standard.components.input.PointerBehavioursComponent)
	public var priority(default,null) : Int;
	
	private var m_entityRef : Entity;
	
	public function new() 
	{
		m_entityRef = null;
		m_pointerBehaviour = null;
	}
	
	public function setEntityRef(entityRef:Entity):Void 
	{
		m_entityRef = entityRef;
	}
	
	public function delete():Void 
	{
		m_pointerBehaviour.delete();
		m_entityRef = null;
	}
	
	
}