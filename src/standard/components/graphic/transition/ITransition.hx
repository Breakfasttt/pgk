package standard.components.graphic.transition;
import flash.display.DisplayObjectContainer;
import msignal.Signal.Signal0;

/**
 * ...
 * @author Breakyt
 */
interface ITransition 
{

	public var onTransition(default,null) : Bool;
	
	public var started(default,null) : Signal0;
	public var finished(default,null) : Signal0;
	
	public function start() : Void;
	public function update(dt : Float) : Void;
	private function end() : Void;
}