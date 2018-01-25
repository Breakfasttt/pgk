package tools.misc;

/**
 * ...
 * @author Breakyt
 */
class Compare 
{

	/**
	 * Compare 2 array of same Type.
	 * If length different => return false,
	 * If ALL of datas are the same in arr1 and arr2, return True, otherwise, return false
	 */
	public static function arrayCompare<T>(arr1 : Array<T>, arr2 : Array<T>)  : Bool
	{
		if (arr1.length != arr2.length)
			return false;
			
		return allDataExist(arr1, arr2);
	}
	
	/**
	 * Check if all data in arr1 exist in arr2.
	 * If all exist, return true, false otherwise.
	 * @param	arr1
	 * @param	arr2
	 * @return
	 */
	public static function allDataExist<T>(arr1 : Array<T>, arr2 : Array<T>) : Bool
	{
		for (data in arr1)
		{
			if (!Lambda.has(arr2, data))
				return false;
		}
		
		return true;
	}
	
}