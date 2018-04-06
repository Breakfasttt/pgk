package assets.tools.spritesheet;
import openfl.geom.Rectangle;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class FlashSpriteSheetFrame 
{

	public var name(default, null) : String;
	
	public var frameRectangle(default, null) : Rectangle;
	public var spriteSourceSize(default, null) : Rectangle;
	
	public var sourceSize(default, null) : Vector2D;
	
	public var rotated : Bool;
	public var trimmed : Bool;
	
	public function new(name : String	, frameRect : Rectangle
										, spriteSourceSize : Rectangle
										, sourceSize : Vector2D, rotated : Bool, trimmed : Bool) 
	{
		this.name = name;
		this.frameRectangle = frameRect;
		this.spriteSourceSize = spriteSourceSize;
		this.sourceSize = sourceSize;
		
		this.rotated = rotated;
		this.trimmed = trimmed;
	}
	
}