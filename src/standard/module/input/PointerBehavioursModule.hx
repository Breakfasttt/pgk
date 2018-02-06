package standard.module.input;

import core.module.Module;
import standard.group.input.PointerBehaviourGroup;

/**
 * A module to manage Pointer Behaviour on entity
 * @author Breakyt
 */
class PointerBehavioursModule extends Module <PointerBehaviourGroup>
{

	public function new() 
	{
		super(PointerBehaviourGroup);
	}
	
	override function onCompGroupAdded(group:PointerBehaviourGroup):Void 
	{
		// todo improve this. not really good to set an entity reference.
		// but actually best method to get necessary composant for behaviour without crete 50k ComponentGroup
		// depending of the entity's data setted by the behaviour.
		group.behaviours.setEntityRef(group.entityRef); 
	}
	
	override function onCompGroupRemove(group:PointerBehaviourGroup):Void 
	{
		group.behaviours.delete();
	}
	
	override public function update(delta:Float):Void 
	{
		
	}
	
}