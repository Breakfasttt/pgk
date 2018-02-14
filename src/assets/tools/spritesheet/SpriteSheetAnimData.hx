package assets.tools.spritesheet;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class SpriteSheetAnimData 
{

	public var name(default,null) : String;
	public var framerate(default,null) : Int;
	public var startindex(default,null): Int;
	public var pivots(default, null) : Array<Vector2D>;
	
	public function new(name : String, framerate : Int, startindex : Int, pivots : Array<Vector2D>) 
	{
		this.name = name;
		this.framerate = framerate;
		this.startindex = startindex;
		this.pivots = pivots;
	}
	
}