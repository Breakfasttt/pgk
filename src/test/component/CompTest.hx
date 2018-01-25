package test.component;

import core.component.Component;

/**
 * A Test and exemple component
 * @author Breakyt
 */
class CompTest extends Component 
{

	public function new() 
	{
		super();
	}
	
	public function test() : Void
	{
		trace("I'm a test component");
	}
	
}