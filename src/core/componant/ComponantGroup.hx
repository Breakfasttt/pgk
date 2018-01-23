package core.componant;
import core.entity.Entity;
import core.module.ModuleManager;

/**
 * ...
 * @author Breakyt
 */
class ComponantGroup 
{

	public var entityRef(default, null ) : Entity;
	
	public function new(entity : Entity) 
	{
		this.entityRef = entity;
	}
	
	/**
	 * Safe delete, Don't override it. 
	 * Override customDelete
	 */
	public function delete() : Void
	{
		this.entityRef = null;
		customDelete();
	}
	
	/**
	 * Override it on sub Class
	 */
	public function customDelete() : Void
	{
		
	}
	
}