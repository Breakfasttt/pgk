package standard.components.input;

import core.component.Component;
import core.entity.Entity;
import input.behaviour.PointerBehaviour;
import standard.components.space2d.Position2D;
import standard.components.space2d.UtilitySize2D;

/**
 * A Component to manage PointerBehaviour with an entity
 * @author Breakyt
 */
class PointerBehaviourComponent extends Component 
{
	private var m_pointerBehaviour : PointerBehaviour;
	
	/**
	 * The entityRef if you need some component on it like position, etc.  Using m_entityRef.get();
	 * Only set on setEntity Function. so be carefull of null variable
	 */
	private var m_entityRef : Entity;
	
	public function new() 
	{
		super();
		m_pointerBehaviour = null;
	}
	
	public function setEntityRef(entityRef : Entity) : Void
	{
		m_entityRef = entityRef;
	}
	
	override public function delete():Void 
	{
		m_entityRef = null;
		
		if (m_pointerBehaviour != null)
			m_pointerBehaviour.delete();
	}
}