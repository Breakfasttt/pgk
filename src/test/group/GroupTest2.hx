package test.group;

import core.component.ComponentGroup;
import core.entity.Entity;
import test.component.CompTest;
import test.component.CompTest2;

/**
 * Another Test and Exemple ComponentGroup using CompTest1 & CompTest2
 * @author Breakyt
 */
class GroupTest2 extends ComponentGroup 
{

	public var test1 : CompTest;
	public var test2 : CompTest2;
	
	public function new() : Void
	{
		super();
		bindFieldType(CompTest, "test1");
		bindFieldType(CompTest2, "test2");
	}
}