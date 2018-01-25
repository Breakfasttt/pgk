package tools.math;

/**
 * Represents a Point or a Vector on a 2D space
 * @author Breakyt
 */
class Vector2D 
{

	/**
	 * the X coordinate
	 */
	public var x : Float;
	
	/**
	 * the X coordinate
	 */
	public var y : Float;
	
	/**
	 * @param	x coordinate
	 * @param	y coordinate
	 */
	public function new(x : Float = 0.0, y : Float = 0.0) : Void
	{
		this.x = x;
		this.y = y;
	}
	
	/**
	 * Add p coordinate with this Vector2D.
	 * This operation modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 * if 'p' is null, operation is abort
	 * return 'this'
	 * @param	p
	 * @return this
	 */
	public inline function add(p : Vector2D) : Vector2D
	{
		if (p == null)
			return this;
		
		this.x += p.x;
		this.y += p.y;
		return this;
	}
	
	/**
	 * Scale the coordinates by a factor.
	 * This operation modify 'this' Vector2D
	 * @param	factor
	 * @return 'this'
	 */
	public inline function scale(factor : Float) : Vector2D
	{
		this.x *= factor;
		this.y *= factor;
		return this;
	}
	
	/**
	 * Scale the coordinates by 1/factor.
	 * This operation modify 'this' Vector2D
	 * @param	factor
	 * @return 'this'
	 */
	public inline function aScale(factor : Float) : Vector2D
	{
		return this.scale(1/factor);
	}
	
	/**
	 * Multiply p coordinate with 'this' Vector2D.
	 * This operation modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 * if 'p' is null, operation is abort
	 * return 'this'
	 * @param	p
	 * @return this
	 */
	public inline function multiply(p : Vector2D) : Vector2D
	{
		if (p == null)
			return this;
			
		this.x *= p.x;
		this.y *= p.y;
		return this;
	}
	
	
	/**
	 * Divide p coordinate with 'this' Vector2D.
	 * This operation modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 * if 'p' is null, operation is abort
	 * return 'this'
	 * @param	p
	 * @return this
	 */
	public inline function divide(p : Vector2D) : Vector2D
	{
		if (p == null)
			return this;
			
		this.x /= p.x;
		this.y /= p.y;
		return this;
	}
	
	
	/**
	 * Normalize 'this' Vector2D.
	 * This operation modify 'this' Vector2D
	 * @return 'this'
	 */
	public inline function normalize() : Vector2D
	{
		var l : Float = length();
		
		if (l == 0)
			return this;
			
		this.x /= l;
		this.y /= l;
		return this;
	}
	
	/**
	 * copy p coordinate on 'this' Vector2D.
	 * This operation modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 * if 'p' is null, operation is abort
	 * return 'this'
	 * @param	p
	 * @return this
	 */
	public inline function copy(p : Vector2D) : Vector2D
	{
		if (p == null)
			return this;
			
		this.x = p.x;
		this.y = p.y;
		return this;
	}
	
	/**
	 * @return true if 'p' exist and coordinate is the same as 'this'
	 * false otherwise
	 * This operation doesn't modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 */
	public inline function isEquals(p : Vector2D) : Bool
	{
		return (p != null && this.x == p.x && this.y == p.y);
	}
	
	/**
	 * @return the length of 'this' Vector2D
	 */
	public inline function length() : Float
	{
		return Math.sqrt(sqLength());
	}
	
	/**
	 * @return the Squarelength of 'this' Vector2D
	 */
	public inline function sqLength() : Float
	{
		return this.x * this.x + this.y * this.y;
	}
	
	/**
	 * Return the dot product between 'p' and 'this'
	 * return 0.0 if 'p' is null
	 * This operation doesn't modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 */
	public inline function dot(p : Vector2D) : Float
	{
		if (p == null)
			return 0.0;
			
		return this.x * p.x + this.y * p.y;
	}
	
	/**
	 * Return the cross product between 'p' and 'this'
	 * return 0.0 if 'p' is null
	 * This operation doesn't modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 * 
	 * /!\ The result represents the Z value of a Vector3D 
	 * with x and y coordinate at 0.0 due to a 2D space
	 * So we return only the Z value with a float  /!\
	 */
	public inline function cross(p : Vector2D) : Float
	{
		if (p == null)
			return 0.0;
			
		return this.x * p.y + this.y * p.x;
	}
	
	/**
	 * Roate 'this' vector with the given angle in ° (degree)
	 * This operation modify 'this' Vector2D
	 * @param	deg
	 * @return 'this'
	 */
	public function rotation(deg : Float) : Vector2D
	{
		var rad = MathUtils.toRad(deg);
		var newX : Float = this.x * Math.cos(rad) - this.y * Math.sin(rad);
		var newY : Float = this.x * Math.sin(rad) - this.y * Math.cos(rad);
		this.x = newX;
		this.y = newY;
		return this;
	}
	
	/**
	 * Return the angle between 'p' and 'this' vector in ° (degree) by default.
	 * Set 'toRad' to true if you want the value in Radian.
	 * This operation doesn't modify 'this' Vector2D
	 * This operation doesn't modify 'p' vector2D
	 * @param	p
	 * @param	toRad Set 'toRad' to true if you want the value in Radian
	 * @return
	 */
	public function angleBetween(p : Vector2D, toRad : Bool = false) : Float
	{
		if (p == null)
			return 0.0;
			
		var angle : Float = Math.acos(this.dot(p) / (this.length() * p.length()));
		return toRad ? angle : MathUtils.toDeg(angle);
	}
	
	/**
	 * Limit the Lenght of 'this' vector by the specified value 'maxLength'
	 * This operation modify 'this' Vector2D
	 * @param	maxLength
	 * @return
	 */
	public function clamp(maxLength : Float) : Vector2D
	{
		return this.normalize().scale(maxLength);
	}
	
	/**
	 * @return a new Vector2D who is the difference 
	 * between 'p1' and 'p1'. (p2-p1)
	 * This operation doesn't modify 'p1' Vector2D
	 * This operation doesn't modify 'p2' vector2D
	 * return null if p1 or p2 is null
	 */
	public static function vectorTo(p1 : Vector2D, p2 : Vector2D) : Vector2D
	{
		if (p1 == null || p2 == null)
			return null;
		
		var result : Vector2D = new Vector2D();
		result.x = p2.x - p1.x;
		result.y = p2.y - p1.y;
		return result;
	}	
	
	/**
	 * Linear interpolation who return a new Vector 2D with two other Vector2D and a factor.
	 * This operation doesn't modify 'p1' Vector2D
	 * This operation doesn't modify 'p2' vector2D
	 * return null if p1 or p2 is null
	 * @param	p1
	 * @param	p2
	 * @param	factor
	 * @return
	 */
	public static function lerp(p1 : Vector2D, p2: Vector2D, factor : Float) : Vector2D
	{
		if (p1 == null || p2 == null)
			return null;
		
		var newP : Vector2D = new Vector2D();
		newP.x = p1.x + factor * (p2.x - p1.x);
		newP.y = p1.y + factor * (p2.y - p1.y);
		return newP;
	}

	/**
	 * Create a new Vector2D with the same properties of 'p' Vector2D
	 * @param	p
	 * @return
	 */
	public static function clone(p : Vector2D) : Vector2D
	{
		var newP : Vector2D = new Vector2D();
		newP.copy(p);
		return newP;
	}
	
}