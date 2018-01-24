package core.component;

/**
 * A componants represents a collection of data who can be update each frame.
 * @author Breakyt
 */
class Component 
{

	/**
	 * the name of a componants
	 */
	public var name : String;
	
	/**
	 *  A componant represents a script/datas who can be update each frame.
	 *  Each module update componants. A componant must be added to the correct module.
	 * Extend this class to create your own componant.
	 */
	public function new() 
	{
		
	}
	
	public function init(name : String) : Void
	{
		this.name = name;
	}
	
	/**
	 * update the componant
	 * This function need to be override
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