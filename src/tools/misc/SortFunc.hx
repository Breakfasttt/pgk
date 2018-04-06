package tools.misc;

/**
 * ...
 * @author Breakyt
 */
class SortFunc 
{
	
/**
	 * Ordre croissant
	 */
	public static function ascendingFloat(a : Float, b : Float) : Int
	{
		var res : Float = a - b;
		if (res < 0)
			return -1;
		else if (res > 0)
			return 1;
		else
			return 0;
	}
	
	/**
	 * Ordre décroissant
	 */
	public static function descendingFloat(a : Float, b : Float) : Int
	{
		var res : Float = b - a;
		if (res < 0)
			return -1;
		else if (res > 0)
			return 1;
		else
			return 0;
	}

	/**
	 * Ordre croissant
	 */
	public static function ascendingInt(a : Int, b : Int) : Int
	{
		return a - b;
	}
	
	/**
	 * Ordre décroissant
	 */
	public static function descendingInt(a : Int, b : Int) : Int
	{
		return b - a;
	}
	
	/**
	 * Ordre croissant
	 */
	public static function ascendingString(a : String, b : String) : Int
	{
		var aLow : String = a.toLowerCase();
		var bLow : String = b.toLowerCase();
		
		var maxChar : Int = cast(Math.max(aLow.length, bLow.length),Int);
		
		// vérifie les caractères différents entre les 2 chaines
		for (i in 0...maxChar)
		{
			if(aLow.charAt(i) == bLow.charAt(i))
				continue;
			
			if (aLow.charAt(i) < bLow.charAt(i))
				return -1;
			else
				return 1;
		}
		
		//si aucun caractère différent, compare leur longueur ( ex : parle / parlement)
		if (aLow.length < bLow.length)
			return -1;
		else if (aLow.length > bLow.length)
			return 1;
			
		return 0; // sinon c'est le même mot
	}
	
	/**
	 * Ordre décroissant
	 */
	public static function descendingString(a : String, b : String) : Int
	{
		var aLow : String = a.toLowerCase();
		var bLow : String = b.toLowerCase();
		
		var maxChar : Int = cast(Math.max(aLow.length, bLow.length),Int);
		
		// vérifie les caractères différents entre les 2 chaines
		for (i in 0...maxChar)
		{
			if(aLow.charAt(i) == bLow.charAt(i))
				continue;
			
			if (aLow.charAt(i) > bLow.charAt(i))
				return -1;
			else
				return 1;
		}
		
		//si aucun caractère différent, compare leur longueur ( ex : parle / parlement)
		if (aLow.length > bLow.length)
			return -1;
		else if (aLow.length < bLow.length)
			return 1;
			
		return 0; // sinon c'est le même mot
	}
	
	public static function ascendingEnumByIndex(a : EnumValue, b : EnumValue) : Int
	{
		return ascendingInt(a.getIndex(), b.getIndex());	
	}
	
	public static function ascendingEnumByName(a : EnumValue, b : EnumValue) : Int
	{
		return ascendingString(a.getName(), b.getName());	
	}
	
	public static function descendingEnumByIndex(a : EnumValue, b : EnumValue) : Int
	{
		return descendingInt(a.getIndex(), b.getIndex());	
	}
	
	public static function descendingEnumByName(a : EnumValue, b : EnumValue) : Int
	{
		return descendingString(a.getName(), b.getName());	
	}
	
}