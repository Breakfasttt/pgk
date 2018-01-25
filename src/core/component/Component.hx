package core.component;

/**
 * A componants represents a collection of data who can be update by a module
 * @author Breakyt
 */
class Component 
{

	/**
	 *  A component represents a bundle of datas 
	 *  Each module update components. A componant must be added to the correct module using ComponentGroup
	 * Extend this class to create your own component.
	 */
	public function new() 
	{
		
	}
	
	/**
	 * update the component
	 * This function need to be override.
	 * @param	delta
	 */
	public function update(delta : Float) : Void
	{
		
	}
	
	/**
	 * delete reference or other data to release memory
	 * This function need to be override
	 */
	public function delete() : Void
	{
		
	}
	
}