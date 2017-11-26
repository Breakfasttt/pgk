package;

import core.Application;
import input.MouseSignals;
import input.MouseData;
import input.mouseBehaviour.DragBehaviour;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Breakyt
 */
class Main extends Sprite 
{
	private var m_app : Application;
	
	private var m_test : Sprite;
	private var m_mouseBehaviour : DragBehaviour;
	private var m_enable : Bool;
	
	
	public function new() 
	{
		super();
		
		Lib.current.stage.showDefaultContextMenu = false;
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_CLICK, function(osef : Dynamic){})  ;
		
		m_test = new Sprite();
		m_test.graphics.beginFill(0xff00000);
		m_test.graphics.drawRect(0, 0, 50, 50);
		m_test.graphics.endFill();
		
		m_test.x = 50;
		m_test.y = 50;
		
		this.addChild(m_test);
		
		m_enable = true;
		m_mouseBehaviour = new DragBehaviour(m_test);
		m_mouseBehaviour.stageAsBoundary = true;
		//m_mouseBehaviour.setBoundary(0, Lib.current.stage.stageWidth, 0, Lib.current.stage.stageHeight);
		
		m_app = new Application();
		m_app.init("Application test", 800, 600);
	}
}
