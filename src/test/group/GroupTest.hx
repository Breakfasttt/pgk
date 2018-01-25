package test.group;

import core.component.ComponentGroup;
import core.entity.Entity;
import test.component.CompTest;

/**
 * A Test and Exemple ComponentGroup using CompTest
 * @author Breakyt
 */
class GroupTest extends ComponentGroup 
{

	public var test : CompTest;
	
	public function new() : Void
	{
		super();
		bindFieldType(CompTest, "test");
	}
}