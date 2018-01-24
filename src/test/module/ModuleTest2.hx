package test.module;

import core.module.Module;
import test.group.GroupTest;
import test.group.GroupTest2;

/**
 * ...
 * @author Breakyt
 */
class ModuleTest2 extends Module<GroupTest2>
{

	public function new() 
	{
		super(GroupTest2);
	}
	
	
	override function onCompGroupAdded(group:GroupTest2):Void 
	{
		trace("ModuleTest2:: ComponentGroup added");
		trace("ModuleTest2:: Group count : " +  m_compGroups.length);
	}
	
	override function onCompGroupRemove(group:GroupTest2):Void 
	{
		trace("ModuleTest2:: ComponentGroup removed");
		trace("ModuleTest2::Group count : " +  m_compGroups.length);
	}
	
	
	override public function update(delta:Float):Void 
	{
		
		
	}
	
}