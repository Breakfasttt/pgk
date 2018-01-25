package tools.math;

/**
 * Anchors are prefabs Vector2D using ratio value (%) or a pixel position
 * @author Breakyt
 */
class Anchor 
{

	public static var topLeft : Anchor = new Anchor(0.0, 0.0);
	public static var topCenter : Anchor = new Anchor(0.0, 0.5);
	public static var topRight : Anchor = new Anchor(0.0, 1.0);
	
	public static var centerLeft : Anchor = new Anchor(0.5, 0.0);
	public static var center : Anchor = new Anchor(0.5, 0.5);
	public static var centerRight : Anchor = new Anchor(0.5, 1.0);
	
	public static var botLeft : Anchor = new Anchor(1.0, 0.0);
	public static var botCenter : Anchor = new Anchor(1.0, 0.5);
	public static var botRight : Anchor = new Anchor(1.0, 1.0);
	
	public var anchor(default,null) : Vector2D;
	
	public var ratioMode(default, set) : Bool;
	
	public function new(x : Float, y : Float, ratioMode : Bool = true) 
	{
		this.ratioMode = ratioMode;
		this.anchor = new Vector2D(x, y);
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
			this.anchor.clamp(1.0);
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
		return ratioMode
	}
	
}