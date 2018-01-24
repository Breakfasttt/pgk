package test.group;

import core.component.ComponentGroup;
import core.entity.Entity;
import test.component.CompTest;

/**
 * ...
 * @author Breakyt
 */
class GroupTest extends ComponentGroup 
{

	public var test : CompTest;
	
	public function new() : Void
	{
		super();
		addType(CompTest, "test");
	}
}