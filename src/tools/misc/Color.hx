package tools.misc;

/**
 * ...
 * @author Breakyt
 */
class Color 
{

	public static var red : UInt = 0xff0000;
	public static var green : UInt = 0x00ff00;
	public static var blue : UInt = 0x0000ff;
	public static var white : UInt = 0xffffff;
	public static var black : UInt = 0x000000;
	
	public static function randomColor() : UInt
	{
		return Std.int(Math.random() * Color.white);
	}
	
}