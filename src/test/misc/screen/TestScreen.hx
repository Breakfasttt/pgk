package test.misc.screen;

import core.Application;
import core.entity.Entity;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.ScreenContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class TestScreen extends ScreenContainer 
{

	private var m_bg : Entity;
	
	public function new(name:String, appRef:Application, entityFactory:EntityFactory) 
	{
		super(name, appRef, entityFactory);
		
	}
	
	override function configure():Void 
	{
		super.configure();
	}
	
	override function createElement():Void 
	{
		m_bg = this.m_entityFactoryRef.createGameElement("TestScreen_bg", null, "bgplaceholder", 0, Anchor.topLeft, Anchor.topLeft);
		
		this.add(m_bg);
	}
	
}