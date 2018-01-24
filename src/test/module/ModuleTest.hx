package test.module;

import core.module.Module;
import test.group.GroupTest;

/**
 * ...
 * @author Breakyt
 */
class ModuleTest extends Module<GroupTest>
{

	public function new() 
	{
		super(GroupTest);
	}
	
	
	override function onCompGroupAdded(group:GroupTest):Void 
	{
		trace("ModuleTest::Group count : " +  m_componants.length);
	}
	
	override public function update(delta:Float):Void 
	{
		
		
	}
	
}