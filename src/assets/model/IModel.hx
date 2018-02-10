package assets.model;
import assets.model.library.ModelData;
import flash.display.DisplayObjectContainer;

/**
 * @author Breakyt
 */
interface IModel 
{
	public var modelData(default, null) : ModelData;
	
	public var skin(default, null) : DisplayObjectContainer;
	
	public var currentAnim(default, null) : String;
	
	public var currentFrame : Int;
	
	public var loop : Bool;
	
	public var rewind : Bool;
	
	public var animSpeed : Int;
	
	private var m_animsNames : Array<String>;
	
	private function prepare() : Void;
	
	public function delete() : Void;
	
	public function setAnim(animName : String) : Void;
	
	public function getAnims() : Array<String>;
	
	public function goToFrame(frame : Int) : Void;
	
	public function stop() : Void;
	
	public function play() : Void;
	
	public function goToAndStop(frame : Int) : Void;
	
	public function goToAndPlay(frame : Int) : Void;
	
	public function update(dt : Float) : Void;
	
}