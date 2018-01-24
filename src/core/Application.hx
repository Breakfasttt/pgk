package core;
import core.component.Component;
import core.component.ComponentGroup;
import core.entity.Entity;
import core.module.Module;
import core.module.ModuleManager;
import openfl.Lib;
import tools.FrameTicker;

/**
 * ...
 * @author Breakyt
 */
class Application 
{

	public static var self : Application;
	
	public var name(default, null) : String;
	public var width(default, null) : Float;
	public var height(default, null) : Float;
	
	public var tick(default, null) : FrameTicker;
	
	public var modManager(default, null) : ModuleManager;
	
	private var m_entities : Array<Entity>;
	
	public function new() 
	{
		if(Application.self == null)
			Application.self = this;
	}
	
	public function init(name : String, width : Float, height : Float) : Void
	{
		this.name = name;
		this.width = width;
		this.height = height;
		
		this.m_entities = [];
		this.modManager = new ModuleManager();
		
		this.tick = new FrameTicker(Lib.current.stage);
		this.tick.tick.add(update);
		this.tick.start();
	}
	
	private function update(dTime : Float) : Void
	{
		modManager.update(dTime);
	}
	
	public function addEntity(e : Entity) : Bool
	{
		if (Lambda.has(m_entities, e))
			return false;
			
		m_entities.push(e);
		e.compAdded.add(componentOnEntityAdded);
		e.compRemoved.add(componentOnEntityRemoved);
		this.modManager.checkAllModuleMatching(e);
		return true;
	}
	
	public function removeEntity(e : Entity) : Bool
	{
		if (!Lambda.has(m_entities, e))
			return false;
			
		e.compAdded.remove(componentOnEntityAdded);
		e.compRemoved.remove(componentOnEntityRemoved);
		this.modManager.checkModuleOnEntityRemoved(e);
		m_entities.remove(e);
		return true;
	}
	
	public function addModule(m : Module<Dynamic>) : Bool
	{
		var moduleCasted : Module<ComponentGroup> = null;  
		
		try
		{	
			moduleCasted = cast m;
		}
		catch(e : Dynamic)
		{
			trace("CRITICAL - A module exist with a wrong ComponentGroupType. please check");
			return false;
		}
		
		if (this.modManager.addModule(moduleCasted))
		{
			for (e in m_entities)
				this.modManager.createGroupForModuleIfEntityMatching(e, moduleCasted);
				
			return true;
		}
		else
			return false;
	}
	
	public function removeModule(m : Module<Dynamic>) : Bool 
	{
		var moduleCasted : Module<ComponentGroup> = null;  
		try
		{	
			moduleCasted = cast m;
		}
		catch(e : Dynamic)
		{
			trace("CRITICAL - A module exist with a wrong ComponentGroupType. please check");
			return false;
		}
		
		return this.modManager.removeModule(moduleCasted);
	}
	
	private function componentOnEntityAdded(e : Entity) : Void
	{
		this.modManager.checkAllModuleMatching(e);
	}
	
	private function componentOnEntityRemoved(e : Entity) : Void
	{
		this.modManager.checkModuleOnEntityComponentRemoved(e);
	}
	
	
}