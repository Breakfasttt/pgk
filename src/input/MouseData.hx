package input;
import openfl.display.InteractiveObject;
import openfl.geom.Point;

/**
 * ...
 * @author Breakyt
 */
class MouseData 
{
	@:allow(input.MouseSignals)
	public var target(default,null) : InteractiveObject;
	
	@:allow(input.MouseSignals)
	public var localPosition(default,null) : Point;
	
	@:allow(input.MouseSignals)
	public var worldPosition(default,null) : Point;
	
	@:allow(input.MouseSignals)
	public var deltaScroll(default,null) : Float;
	
	@:allow(input.MouseSignals)
	public var altModifier(default,null) : Bool;
	
	@:allow(input.MouseSignals)
	public var ctrlModifier(default,null) : Bool;
	
	public function new() 
	{
		localPosition = new Point();
		worldPosition = new Point();
	}
	
	
	public function toString() : String
	{
		return "target : " + target + " localPosition :"  + localPosition + " worldPosition : " + worldPosition + " deltaScroll : " + deltaScroll  + " altModifier : " + altModifier + " ctrlModifier :" + ctrlModifier; 
	}
}