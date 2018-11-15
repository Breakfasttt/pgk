package standard.components.input;

import core.component.Component;
import core.entity.Entity;
import standard.components.input.utils.EntityPointerBehaviour;

/**
 * A Component to manage EntityPointerBehaviour
 * @author Breakyt
 */
class PointerBehavioursComponent extends Component 
{
	private var m_pointerBehaviours : Array<EntityPointerBehaviour>;
	
	/**
	 * The entityRef if you need some component on it like position, etc.  Using m_entityRef.get();
	 * Only set on setEntity Function. so be carefull of null variable
	 */
	private var m_entityRef : Entity;
	
	public function new() 
	{
		super();
		m_pointerBehaviours = new Array();
	}
	
	public function addBehaviour(behav : EntityPointerBehaviour, priority : Int) : Void
	{
		if (behav == null)
			return;
			
		if (Lambda.has(m_pointerBehaviours, behav))
			return;
		
		behav.priority = priority;
		m_pointerBehaviours.push(behav);
		m_pointerBehaviours.sort(sortBehaviourByPriority);
	}
	
	public function getBehav(index : Int) : EntityPointerBehaviour
	{
		if(index >= 0 && index < m_pointerBehaviours.length)
			return m_pointerBehaviours[index];
		return null;
	}
	
	public function removeBehaviour(behav : EntityPointerBehaviour) : Void
	{
		m_pointerBehaviours.remove(behav);
	}
	
	public function setEntityRef(entityRef : Entity) : Void
	{
		m_entityRef = entityRef;
		
		for (behav in m_pointerBehaviours)
			behav.setEntityRef(entityRef);
	}
	
	override public function delete():Void 
	{
		m_entityRef = null;
		
		for (behav in m_pointerBehaviours)
			behav.delete();
	}
	
	private function sortBehaviourByPriority(a : EntityPointerBehaviour, b : EntityPointerBehaviour) : Int
	{
		if (a.priority < b.priority)
			return -1;
		else if (a.priority > b.priority)
			return 1;
		else
			return 0;
	}
	
}