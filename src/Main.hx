package;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import test.TestMe;

/**
 * ...
 * @author Breakyt
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		
		Lib.current.stage.showDefaultContextMenu = false;
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_CLICK, function(osef : Dynamic){})  ;
		
		//TestMe.testDragMouseBehaviour();
		//TestMe.testApplicationModuleEntityAndComposant();
		TestMe.testDisplayAndRepresentation();

	}
}
