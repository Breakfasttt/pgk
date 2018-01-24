package;

import core.Application;
import core.component.ComponentGroup;
import core.entity.Entity;
import core.module.Module;
import input.MouseSignals;
import input.MouseData;
import input.mouseBehaviour.DragBehaviour;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;
import test.TestMe;
import test.component.CompTest;
import test.component.CompTest2;
import test.module.ModuleTest;
import test.module.ModuleTest2;

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
		
		TestMe.testDragMouseBehaviour();
		TestMe.testApplicationModuleEntityAndComposant();

	}
}
