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

	private var m_entityRef : Entity;
	
	private var m_openTransition : EntityTransition;
	private var m_closeTransition : EntityTransition;
	
	/**
	 * call when open transition end.
	 * PLEASE don't use it directly. USE IT INTO A MODULE. 
	 * This var is public to make use easier on modules classes
	 */
	public var onOpen : Void->Void;
	
	/**
	 * call when close transition end.
	 * PLEASE don't use it directly. USE IT INTO A MODULE. 
	 * This var is public to make use easier on modules classes
	 */
	public var onClose : Void->Void;
	
	public function new(openTransition : EntityTransition, closeTransition : EntityTransition) 
	{
		super();
		m_openTransition = openTransition;
		m_closeTransition = closeTransition;
	}
	
	public function setOpenTransition(openTransition : EntityTransition) : Void
	{
		if (m_openTransition != null && m_openTransition.onTransition)
			return;
		
		m_openTransition = openTransition;
		m_openTransition.setEntityRef(m_entityRef);
	}
	
	public function setCloseTransition(closeTransition : EntityTransition) : Void
	{
		if(m_closeTransition != null && m_closeTransition.onTransition)
			return;
			
		m_closeTransition = closeTransition;
		m_closeTransition.setEntityRef(m_entityRef);
	}
	
	public function setEntityRef(entity : Entity) : Void
	{
		m_entityRef = entity;
		
		if(m_openTransition !=null)
			m_openTransition.setEntityRef(m_entityRef);
		
		if(m_closeTransition != null)
			m_closeTransition.setEntityRef(m_entityRef);
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
	
	public function isOnTransit() : Bool
	{
		var result : Bool = false;
		if (m_openTransition != null && m_openTransition.onTransition)
			result = true;
			
		if(m_closeTransition != null && m_closeTransition.onTransition)
			result = result && true;
		
		return result;
	}
}