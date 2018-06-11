package standard.components.debug;

import core.Application;
import core.component.Component;
import core.entity.Entity;
import standard.components.graphic.display.impl.Layer;
import standard.factory.EntityFactory;

/**
 * ...
 * @author Breakyt
 */
class DebugComp extends Component 
{

	public function new() 
	{
		super();
	}
	
	public function initWhenAdded(appRef : Application, layerEntityRef : Entity, entityFactoryRef : EntityFactory) : Void
	{
		//to override
	}
	
	public function deleteWhenRemove(appRef : Application, layerEntityRef : Entity, entityFactoryRef : EntityFactory) : Void
	{
		//to override
	}
	
}