package standard.components.graphic.transition.impl;
import core.entity.Entity;
import msignal.Signal.Signal0;
import standard.components.graphic.transition.ITransition;

/**
 * ...
 * @author Breakyt
 */
class EntityTransition implements ITransition
{

	private var m_entityRef : Entity;
	
	public var onTransition(default,null) : Bool
	
	public var started(default,null) : Signal0;
	public var finished(default,null) : Signal0;
	
	public function new();
	{
		
		onTransition = false;
		this.start = new Signal0();
		this.finished = new Signal0();
	}
	
	public function setEntityRef(entityRef : Entity) : Void
	{
		m_entityRef = entityRef;
	}
	
	public function start() : Void
	{
		trace("EntityTransition::start::please override it");
	}
	
	public function update(dt : Float) : Void
	{
		trace("EntityTransition::update::please override it");
	}
	
	private function end() : Void
	{
		trace("EntityTransition::end::please override it");
	}
	
}