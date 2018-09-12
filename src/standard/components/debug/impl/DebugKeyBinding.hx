package standard.components.debug.impl;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import standard.factory.EntityFactory;
import core.entity.Entity;

import core.Application;
import standard.components.debug.DebugComp;

/**
 * ...
 * @author Breakyt
 */
class DebugKeyBinding extends DebugComp 
{

	private var m_callBacks : Map<Int, Void->Void>;
	
	public function new() 
	{
		super();
		m_callBacks = new Map();
	}
	
	override public function initWhenAdded(appRef:Application, layerEntityRef:Entity, entityFactoryRef:EntityFactory):Void 
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	override public function deleteWhenRemove(appRef:Application, layerEntityRef:Entity, entityFactoryRef:EntityFactory):Void 
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
		
	public function addCallBack(keycode : Int, cb : Void->Void) : Void
	{
		m_callBacks.set(keycode, cb);
	}
	
	private function onKeyDown(event : KeyboardEvent) : Void
	{
		var cb : Void->Void = m_callBacks.get(event.keyCode);	
		if (cb != null)
			cb();
	}
	
}