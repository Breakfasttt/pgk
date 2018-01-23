package core;
import core.componant.Componant;
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
		
		this.modManager = new ModuleManager();
		
		this.tick = new FrameTicker(Lib.current.stage);
		this.tick.tick.add(update);
		this.tick.start();
	}
	
	private function update(dTime : Float) : Void
	{
		modManager.update(dTime);
	}
	
	
}