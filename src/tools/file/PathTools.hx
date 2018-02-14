package tools.file;
import haxe.io.Path;

/**
 * Some Tools to manage Path String
 * @author
 */
class PathTools
{

	/**
	 * Return the file extension if exist. Else return empty String.
	 * The extension will be lower case.
	 */
	public static function getExtension(file : String) : String
	{
		var splitted : Array<String> = file.split(".");
		
		if (splitted == null)
			return "";
		else if (splitted.length <= 1) //1 if splitted have only 1 element, it can't be the extension
			return "";
		
		return splitted[splitted.length - 1].toLowerCase();
	}
	
	/**
	 * Return only the path of a given pathFile. Return empty if no path found
	 * exemple : "c:\my\path\myfile.txt" => return c:\my\path\
	 * exemple 2 : "myfile.txt" => return ""
	 */
	public static function getPath(filePath : String) : String
	{
		var path : String = replaceBackSlash(filePath);
		var fileName : String = getFileName(filePath);
		if (fileName == "")
			return addFinalSlash(path);
		
		path = StringTools.replace(path, fileName, "");
		return addFinalSlash(path);
	}
	
	/**
	 * Return only the file name (with his extension). Return the given String if not found
	 * (exemple : "c:\my\path\myfile.txt" => return "myfile.txt")
	 * (exemple 2 : "myfile.txt" => return myfile.txt)
	 */
	public static function getFileName(filePath : String, withExtension : Bool = true) : String
	{
		var tempFilePath = replaceBackSlash(filePath);
		var splitted : Array<String> = tempFilePath.split("/");
		
		if (splitted == null)
			return filePath;
		else if (splitted.length == 0)
			return filePath;
		
		if(withExtension)
			return splitted[splitted.length - 1];
			
		var extSplited : Array<String> = splitted[splitted.length - 1].split(".");
		
		if (extSplited == null)
			return splitted[splitted.length - 1];
		else if (extSplited.length <= 0)
			return splitted[splitted.length - 1];
		
		return extSplited[0];
	}
	
	/**
	 * return given path with a '/' if there isn't one
	 * if 'path' parameters is null => return null
	 * if 'path' parameters have an extension (not a path) return => path
	 */
	public static function addFinalSlash (path : String) : String
	{
		if (path == null)
			return null;
		else if (getExtension(path) != "")
			return path;
		else if( path.charAt(path.length - 1) != "/")
			return path + "/";
		return path;
	}
	
	public static function removeFinalSlash(path : String) : String
	{
		if (path == null || path == "")
			return null;
		else if( path.charAt(path.length - 1) != "/")
			return path;
			
		return path.substring(0, path.length - 1);
	}
	
	/**
	 * Replace all "\" by "/" in a path
	 */
	public static function replaceBackSlash(path : String) : String
	{
		return (StringTools.replace(path, "\\", "/"));
	}
	
	/**
	 * Replace all "/" by "\" in a path
	 */
	public static function replaceSlash(path : String) : String
	{
		return (StringTools.replace(path, "/", "\\"));
	}
	
	/**
	 * Concatene a path with a folder (ignore path symbole like '.' or '..')
	 * Return 'path' parameters if folder is NULL or empty string ("")
	 * Return empty string("") if path is NULL
	 * ex : folder = "lib/"  path = "my/path/img.png" => lib/my/path/img.png
	 * ex : folder = "lib/"  path = "../my/path/img.png" => lib/my/path/img.png
	 * /!\ PATH PARAMETER MUST BE RELATIVE !!
	 */
	public static function concatRelativePath(folderPath : String, path : String) : String
	{
		if (path == null)
			return "";
		else if (folderPath == "")
			return path;
		else if (folderPath == null)
			return path;
		
		path = replaceBackSlash(path);
		folderPath = addFinalSlash(folderPath);
		var splitted : Array<String> = path.split("/");

		for (i in 0...splitted.length)
		{
			if (splitted[i] == "." || splitted[i] == "..")
				continue;
			
			var ext : String =	getExtension(splitted[i]);
			var backSlash  : String  = ext == "" ? "/" : "";
			folderPath += splitted[i] + backSlash;
		}
		return folderPath;
	}
	
	/**
	 * Get a normalized path with a relative path and a reference path (not necessary an absolute path) 
	 * return path if referencePath is null or empty ("")
	 * return referencePath if path is null or empty ("")
	 * return referencePath if path is absolute
	 * return concatRelativePath(referencePath, path) if too many "../" in relative path
	 * if referencePath is absolute, the normalized path "/" is replace by \\
	 * 
	 * ex : normalize("", ../test.png) return "../test.png"
	 * ex : normalize("", "") return ""
	 * ex : normalize("c:/exemple/assets/", null) return "c:\\exemple\\assets\\"
	 * ex : normalize("c:/exemple/assets/", "../../../test.png") return "c:\\exemple\\assets\\" (too many ../)
	 * ex : normalize("c:/exemple/assets/", "../../test.png") return "c:\\test.png" 
	 * ex : normalize("../exemple/assets/", "../test.png") return "../exemple/test.png"
	 * ex : normalize("../exemple/assets/", "../../test.png") return "../test.png" 
	 * 
	 * @param	referencePath
	 * @param	path
	 * @return
	 */
	public static function normalize(referencePath : String, path : String) : String
	{
		if (referencePath == null || referencePath == "")
			return path;
		else if (path == null)
			return referencePath;
		else if (path == "")
			return referencePath;
		else if (isAbsolute(path))
			return referencePath;
			
		path = replaceBackSlash(path);
		referencePath = replaceBackSlash(referencePath);
		referencePath = removeFinalSlash(referencePath);
		
		var splittedPath : Array<String> = path.split("/");
		var splittedReferencePath : Array<String> = referencePath.split("/");
		
		for (i in 0...splittedPath.length)
		{
			if (splittedPath[i] == ".")
			{
				continue;
			}
			else if (splittedPath[i] == "..")
			{
				if (splittedReferencePath.length <= 1)
				{
					// if there are too many "..", we ignore it
					return concatRelativePath(referencePath, path);
				}
				else
					splittedReferencePath.pop();
			}
			else
				splittedReferencePath.push(splittedPath[i]);
		}
		
		var fullpath : String = "";

		if (isAbsolute(referencePath))
			fullpath = splittedReferencePath.join("\\");
		else
			fullpath = splittedReferencePath.join("/");
		
		return fullpath;
	}
	
	/**
	 * return true for an absolute path.
	 * /!\ only check for local Windows path  (C:\ etc.
	 * @param	path
	 * @return
	 */
	public static function isAbsolute(path : String) : Bool
	{
		return path.charAt(1) == ':';
	}
	
	
	
	//todo :
	// - add a function to test if the path is absolute
	// - add a function to test if the path is retaltiv
	// - add a function to change an absolute path to a relative path
	// - add a function to change a relative path to an absolute path
}