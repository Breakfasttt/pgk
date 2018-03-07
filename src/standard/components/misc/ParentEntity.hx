package standard.components.misc;

import core.component.Component;
import core.entity.Entity;
import msignal.Signal.Signal0;

/**
 * ...
 * @author Breakyt
 */
class ParentEntity extends Component 
{

	public var parentEntity(default, null) : Entity;
	
	public var parentChange(default, null) : Signal0;
	
	public function new(parentEntity : Entity) 
	{
		super();
		this.parentEntity = parentEntity;
		this.parentChange = new Signal0();
	}
	
	public function setParent(entity : Entity) : Void
	{
		this.parentEntity = entity;
		this.parentChange.dispatch();
	}
	
	override public function delete():Void 
	{
		this.parentEntity = null;
		this.parentChange.removeAll();
		this.parentChange = null;
	}
	
}