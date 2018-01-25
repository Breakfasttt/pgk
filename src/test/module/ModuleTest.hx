package test.module;

import core.module.Module;
import test.group.GroupTest;

/**
 * A Test and Exemple Module using => GroupTest extends ComponentGroup
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
		trace("ModuleTest:: ComponentGroup added");
		trace("ModuleTest:: Group count : " +  m_compGroups.length);
	}
	
	override function onCompGroupRemove(group:GroupTest):Void 
	{
		trace("ModuleTest:: ComponentGroup removed");
		trace("ModuleTest::Group count : " +  m_compGroups.length);
	}
	
	
	override public function update(delta:Float):Void 
	{
		
		
	}
	
}