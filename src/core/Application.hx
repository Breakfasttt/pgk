package core;
import core.component.ComponentGroup;
import core.entity.Entity;
import core.module.Module;
import core.module.ModuleManager;
import openfl.Lib;
import tools.math.Vector2D;
import tools.time.FrameTicker;

/**
 * This class is the start point of an Application.
 * They manage Module and Entity and specific data to running correctly the App.
 * @author Breakyt
 */
class Application 
{

	/**
	 * The singleton to get easily the main Application
	 * Application.self.
	 * The first new Application you create is store here.
	 * But you can manage your own reference of the app, or create multiple Application object if you want.
	 */
	public static var self : Application;
	
	/**
	 * Name of the Application
	 */
	public var name(default, null) : String;
	
	/**
	 * Utility Width of the Application
	 */
	public var width(default, null) : Float;
	
	/**
	 * Utility Width of the Application
	 */
	public var height(default, null) : Float;
	
	/**
	 * Shortcut to application main screen ratio (width/height);
	 */
	public var appRatio(default, null) : Float;
	
	/**
	 * The frame ticker of the application.
	 * Usefull for updating module and get Fps.
	 */
	public var tick(default, null) : FrameTicker;
	
	/**
	 * The module manager. Use it if you need to get a specific module.
	 */
	public var modManager(default, null) : ModuleManager;
	
	/**
	 * All entities added on the application
	 */
	private var m_entities : Array<Entity>;
	
	/**
	 * All entities name use.
	 * Usefull to check entity unique name.
	 */
	private var m_entitiesNameAdded : Array<String>;
	
	/**
	 * A map to add a number to entities Name Already Used to keep name unique;
	 */
	private var m_entitiesNameCounter : Map<String, Int>;
	
	public function new() 
	{
		if(Application.self == null)
			Application.self = this;
	}
	
	/**
	 * Init the application with given properties.
	 * @param	name
	 * @param	width
	 * @param	height
	 */
	public function init(name : String, width : Float, height : Float) : Void
	{
		this.name = name;
		this.width = width;
		this.height = height;
		this.appRatio = this.width / this.height;
		
		this.m_entities = new Array<Entity>();
		this.m_entitiesNameAdded = new Array<String>();
		this.m_entitiesNameCounter = new Map<String, Int>();
		
		this.modManager = new ModuleManager();
		
		this.tick = new FrameTicker(Lib.current.stage);
		this.tick.tick.add(update);
		this.tick.start();
	}
	
	/**
	 * Update the application.
	 * (for now update only all modules subscribe to the app)
	 * @param	dTime
	 */
	private function update(dTime : Float) : Void
	{
		modManager.update(dTime);
	}
	
	/**
	 * Add an entity to the application.
	 * Inform all modules of this addition and create new ComponentGroup on these modules depending
	 * of Components already added to the given entity
	 * If a Component his added on the given entity after this addition, ComponentGroup for modules will be still created
	 * @param	e
	 * @return
	 */
	public function addEntity(e : Entity) : Bool
	{
		if (Lambda.has(m_entities, e))
			return false;
			
		m_entities.push(e);
		checkEntityName(e);
		e.compAdded.add(componentOnEntityAdded);
		e.compRemoved.add(componentOnEntityRemoved);
		this.modManager.checkAllModuleMatching(e);
		return true;
	}
	
	
	private function checkEntityName(e : Entity) : Void
	{
		var valideName : String = e.name;
		var count : Int = 0;
		
		while (Lambda.has(this.m_entitiesNameAdded, valideName))
		{
			if (m_entitiesNameCounter.exists(valideName))
			{
				count = m_entitiesNameCounter.get(valideName);
				count += 1;
				m_entitiesNameCounter.set(valideName, count);
			}
			else
			{
				count = 1;
				m_entitiesNameCounter.set(valideName, count);
			}
				
			valideName =  e.name + "_" + count;
		}
		
		m_entitiesNameAdded.push(valideName);
		
		if (valideName != e.name)
			trace("Entity renamed because his old name already exist. Old : " + e.name + " New : " + valideName);
		
		e.name = valideName;
	}
	
	/**
	 * remove an entity from the application.
	 * Inform all modules of this remove and delete associed ComponentGroup on these modules.
	 * @param	e
	 * @return
	 */
	public function removeEntity(e : Entity) : Bool
	{
		if (!Lambda.has(m_entities, e))
			return false;
			
		e.compAdded.remove(componentOnEntityAdded);
		e.compRemoved.remove(componentOnEntityRemoved);
		this.modManager.checkModuleOnEntityRemoved(e);
		m_entities.remove(e);
		m_entitiesNameAdded.remove(e.name);
		m_entitiesNameCounter.remove(e.name);
		return true;
	}
	
	/**
	 * Add a module to the application.
	 * Only one module by type can be added. 
	 * (You can't add multiple TestModule for exemple)
	 * @param	m
	 * @return
	 */
	public function addModule(m : Module<Dynamic>, priority : Int = -1) : Bool
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
		
		if (this.modManager.addModule(this, moduleCasted, priority))
		{
			for (e in m_entities)
				this.modManager.createGroupForModuleIfEntityMatching(e, moduleCasted);
				
			return true;
		}
		else
			return false;
	}
	
	/**
	 * Remove the given module from application
	 * @param	m
	 * @return
	 */
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
	
	/**
	 * Tools function to inform module when a subscriber entity add a new component on it.
	 * @param	e
	 */
	private function componentOnEntityAdded(e : Entity) : Void
	{
		this.modManager.checkAllModuleMatching(e);
	}
	
	/**
	 * Tools function to inform module when a subscriber entity remove a component on it.
	 * @param	e
	 */
	private function componentOnEntityRemoved(e : Entity) : Void
	{
		this.modManager.checkModuleOnEntityComponentRemoved(e);
	}
	
	
}