package;

import input.MouseSignals;
import input.MouseData;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Breakyt
 */
class Main extends Sprite 
{
	private var m_test : Sprite;
	private var m_mouseBehaviour : MouseSignals;
	private var m_enable : Bool;
	
	
	public function new() 
	{
		super();
		
		Lib.current.stage.showDefaultContextMenu = false;
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_CLICK, function(osef : Dynamic){})  ;
		
		m_test = new Sprite();
		m_test.graphics.beginFill(0xff00000);
		m_test.graphics.drawCircle(50, 50, 25);
		m_test.graphics.endFill();
		
		m_test.x = 50;
		m_test.y = 50;
		
		this.addChild(m_test);
		
		m_enable = true;
		m_mouseBehaviour = new MouseSignals(m_test, true, true, true, true);
		m_mouseBehaviour.releaseOutsideObject = true;
		m_mouseBehaviour.releaseWithRollOut = false;
		
		//m_mouseBehaviour.rollOver.add(test);
		m_mouseBehaviour.leaveWorld.add(moveCb);
		m_mouseBehaviour.rightPress.add(test);
		m_mouseBehaviour.rightRelease.add(moveCb);
		//m_mouseBehaviour.move.add(moveCb);
		
	}
	
	private function test(data : MouseData) : Void
	{
		m_test.alpha = 0.50;
	}
	
	private function moveCb(data : MouseData) : Void
	{
		m_test.alpha = 1.00;
	}

}
