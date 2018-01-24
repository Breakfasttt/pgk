package test.group;

import core.component.ComponentGroup;
import core.entity.Entity;
import test.component.CompTest;
import test.component.CompTest2;

/**
 * ...
 * @author Breakyt
 */
class GroupTest2 extends ComponentGroup 
{

	public var test1 : CompTest;
	public var test2 : CompTest2;
	
	public function new() : Void
	{
		super();
		addType(CompTest, "test1");
		addType(CompTest2, "test2");
	}
}