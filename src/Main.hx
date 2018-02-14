package;

import haxe.Timer;
import openfl.events.Event;
import tools.debug.ExecTimeCounter;
import openfl.Lib;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import test.TestMe;
import standard.module.graphic.LayerModule;

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
		this.addEventListener(Event.ADDED_TO_STAGE, onMainAddedToStage);
	}
	
	private function onMainAddedToStage(event : Event) : Void
	{
		trace("=== Application starting.... ======");
		this.removeEventListener(Event.ADDED_TO_STAGE, onMainAddedToStage);
		var counter : ExecTimeCounter = new ExecTimeCounter();
		//counter.start();
		TestMe.testDragMouseBehaviour();
		//counter.stop();
		trace("elapsed : " + counter.timeElapsed);
		//TestMe.testApplicationModuleEntityAndComposant();
		//TestMe.testDisplayAndRepresentation();		
	}
}
