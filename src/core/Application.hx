package core;
import core.componant.Componant;
import core.module.Module;
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
	
	private var m_modules : Array<Module<Componant>>;
	
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
		
		m_modules = new Array();
		
		this.tick = new FrameTicker(Lib.current.stage);
		this.tick.tick.add(update);
		this.tick.start();
	}
	
	private function update(delta : Float) : Void
	{
		for (mod in m_modules)
			mod.update(delta);
	}
	
	public function addModule(module : Module<Componant>) : Void
	{
		m_modules.push(module);
	}
	
	public function getModule<T>(modType : Class<T>) : Module<Componant>
	{
		for (mod in m_modules)
		{
			if (mod.isCompatible(modType))
				return mod;
		}
		
		return null;
		
	}
	
	public function getModuleByName(name : String) : Module<Dynamic>
	{
		for (mod in m_modules)
		{
			if (mod.name == name)
				return mod;
		}
		
		return null;
	}
	
}