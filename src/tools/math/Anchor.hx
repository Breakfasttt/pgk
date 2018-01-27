package tools.math;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

/**
 * Anchors are prefabs Vector2D using ratio value (%) or a pixel position
 * @author Breakyt
 */
class Anchor 
{

	public static var topLeft(get, null) : Anchor = new Anchor(0.0, 0.0);
	public static var topCenter(get, null) : Anchor = new Anchor(0.5, 0.0);
	public static var topRight(get, null) : Anchor = new Anchor(1.0, 0.0);
	
	public static var centerLeft(get, null) : Anchor = new Anchor(0.0, 0.5);
	public static var center(get, null) : Anchor = new Anchor(0.5, 0.5);
	public static var centerRight(get, null) : Anchor = new Anchor(1.0, 0.5);
	
	public static var botLeft(get, null) : Anchor = new Anchor(0.0, 1.0);
	public static var botCenter(get, null) : Anchor = new Anchor(0.5, 1.0);
	public static var botRight(get, null) : Anchor = new Anchor(1.0, 1.0);
	
	public var anchor(default,null) : Vector2D;
	
	public var ratioMode(default, set) : Bool;
	
	public function new(x : Float, y : Float, ratioMode : Bool = true) 
	{
		this.anchor = new Vector2D(x, y);
		this.ratioMode = ratioMode;
		checkRatioMode();
	}
	
	public function setValue(x : Float, y : Float) : Void
	{
		this.anchor.x = x;
		this.anchor.y = y;
		checkRatioMode();
	}
	
	public function addValue(x : Float, y : Float) : Void
	{
		this.anchor.x += x;
		this.anchor.y += y;
		checkRatioMode();
	}
	
	private function checkRatioMode() : Void
	{
		if (this.ratioMode)
			this.anchor.limits(0.0, 1.0);
	}
	
	public function relocate(obj : DisplayObject, widthRef : Float = 0.0, heightRef : Float = 0.0) : Void
	{
		if (obj == null)
			return;
		
		if (ratioMode)
		{
			obj.x = widthRef * anchor.x;
			obj.y = heightRef * anchor.y;
		}
		else
		{
			obj.x = anchor.x;
			obj.y = anchor.y;	
		}
	}
	
	public function applyOffset(obj : DisplayObject, widthRef : Float = 0.0, heightRef : Float = 0.0, invertRatioOffset : Bool = false) : Void
	{
		if (obj == null)
			return;
		
		if (ratioMode)
		{
			var invert : Float = invertRatioOffset ? -1 : 1;
			obj.x -= widthRef * anchor.x * invert;
			obj.y -= heightRef * anchor.y * invert;
		}
		else
		{
			obj.x += anchor.x;
			obj.y += anchor.y;	
		}
	}
	
	/**
	 * Create a clone of 'this' anchor
	 * @return
	 */
	public function clone() : Anchor
	{
		return new Anchor(this.anchor.x, this.anchor.y, this.ratioMode);
	}
	
	private function set_ratioMode(value:Bool):Bool 
	{
		ratioMode = value;
		checkRatioMode();
		return ratioMode;
	}
	

	
	static function get_topLeft():Anchor 
	{
		return topLeft.clone();
	}
	
	static function get_topCenter():Anchor 
	{
		return topCenter.clone();
	}
	
	static function get_topRight():Anchor 
	{
		return topRight.clone();
	}
	
	static function get_centerLeft():Anchor 
	{
		return centerLeft.clone();
	}
	
	static function get_center():Anchor 
	{
		return center.clone();
	}
	
	static function get_centerRight():Anchor 
	{
		return centerRight.clone();
	}
	
	static function get_botLeft():Anchor 
	{
		return botLeft.clone();
	}
	
	static function get_botCenter():Anchor 
	{
		return botCenter.clone();
	}
	
	static function get_botRight():Anchor 
	{
		return botRight.clone();
	}	
	
	
}