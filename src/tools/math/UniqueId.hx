package tools.math;

/**
 * ...
 * @author ...
 */
class UniqueId
{

	static var m_allChar : String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

	public static function generate(size : Null<Int> = 255, chars : String = null) : String 
	{ 
		if (size == null) 
			size = 255;
			
		if (chars == null)
			chars = m_allChar;
			
		var nchars = chars.length; 
		var uid = ""; 
		
		for (i in 0 ... size)
			uid += chars.charAt( Std.int(Math.random() * nchars) );
		
		return uid; 
	}
}