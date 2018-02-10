package assets.model;
import assets.model.library.ModelData;
import flash.display.DisplayObjectContainer;
import openfl.display.Sprite;
import tools.misc.Color;

/**
 * ...
 * @author Breakyt
 */
class Model implements IModel 
{

	public static var firstFrameAnim(default, null) : String = "firstFrameAnim";
	
	public var modelData(default, null) : ModelData;
	
	public var skin(default, null):DisplayObjectContainer;
	
	private var m_animsNames : Array<String>;
	
	public var currentAnim(default, null) : String;
	
	public var currentFrame:Int;
	
	public var loop:Bool;
	
	public var rewind:Bool;
	
	public var animSpeed:Int;
	
	public function new(modelData : ModelData) 
	{
		this.modelData = modelData;
		this.skin = null;
		m_animsNames = new Array();
		this.currentAnim = Model.firstFrameAnim;
		this.currentFrame = 1;
		this.loop = true;
		this.rewind = false;
		this.animSpeed = 30;
		this.prepare();
	}	
	
	function prepare():Void 
	{
		trace("Model:: prepare() must be override");
	}
	
	public function delete():Void 
	{
		trace("Model:: delete() must be override");
	}
	
	public function setAnim(animName:String):Void 
	{
		trace("Model:: setAnim() must be override");
	}
	
	public function getAnims():Array<String> 
	{
		return m_animsNames.copy();
	}
	
	
	public function goToFrame(frame:Int):Void 
	{
		trace("Model:: goToFrame() must be override");
	}
	
	public function stop():Void 
	{
		trace("Model:: stop() must be override");
	}
	
	public function play():Void 
	{
		trace("Model:: play() must be override");
	}
	
	public function goToAndStop(frame:Int):Void 
	{
		this.goToAndStop(frame);
		this.stop();
	}
	
	public function goToAndPlay(frame:Int):Void 
	{
		this.goToAndPlay(frame);
		this.play();
	}
	
	public function update(dt : Float) : Void
	{
		trace("Model:: update() must be override");
	}
	
	/**
	 * Usefull function to create a square when a Display doesn't exist or can't be created.
	 * @return Sprite
	 */
	private function createSquare(w : Float = 50.0, h : Float = 50, color : Null<UInt> = null) : Sprite
	{
		if (color == null)
			color = Color.randomColor();
		
		var result : Sprite = new Sprite();
		result.graphics.beginFill(color);
		result.graphics.drawRect(0, 0, w, h);
		result.graphics.endFill();
		return result;
	}		
	
}