package tools.math;

/**
 * A collection of Math static function
 * @author Breakyt
 */
class MathUtils 
{

	public static function toRad(deg : Float) : Float
	{
		return deg * Math.PI / 180.0;
	}
	
	public static function toDeg(rad : Float) : Float
	{
		return rad * 180.0 / Math.PI;
	}
	
}