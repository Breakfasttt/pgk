package standard.components.graphic.transition;

import core.component.Component;
import core.entity.Entity;
import standard.components.graphic.transition.impl.EntityTransition;

/**
 * todo => find a better name
 * A component containing 2 transition. Once for an opening transition (like popup apparition)
 * an other for closing transition (like popup vanishing)
 * @author Breakyt
 */
class Opener extends Component 
{

	private var m_openTransition : EntityTransition;
	private var m_closeTransition : EntityTransition;
	
	public var onOpen : Void->Void;
	public var onClose : Void->Void;
	
	public function new(openTransition : EntityTransition, closeTransition : EntityTransition) 
	{
		super();
		m_openTransition = openTransition;
		m_closeTransition = closeTransition;
		
	}
	
	public function setEntityRef(entity : Entity) : Void
	{
		if(m_openTransition !=null)
			m_openTransition.setEntityRef(entity);
		
		if(m_closeTransition != null)
			m_closeTransition.setEntityRef(entity);
	}
	
	public function open() : Void
	{
		if (m_openTransition == null)
		{
			if(onOpen != null)
				onOpen();
			return;
		}
			
		
		if (m_closeTransition.onTransition || m_openTransition.onTransition)
			return;
		
		m_openTransition.finished.addOnce(onOpen);
		m_openTransition.start();
	}
	
	
	public function close() : Void
	{
		if (m_closeTransition == null)
		{
			if(onClose != null)
				onClose();
			return;
		}
		
		if (m_closeTransition.onTransition || m_openTransition.onTransition)
			return;
			
		m_closeTransition.finished.addOnce(onClose);
		m_closeTransition.start();
		
	}
	
	override public function update(delta:Float):Void 
	{
		if (m_openTransition != null && m_openTransition.onTransition)
			m_openTransition.update(delta);
		
		if (m_closeTransition != null &&m_closeTransition.onTransition)
			m_closeTransition.update(delta);
	}
}