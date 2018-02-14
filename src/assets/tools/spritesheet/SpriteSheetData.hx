package assets.tools.spritesheet;

/**
 * ...
 * @author Breakyt
 */
class SpriteSheetData 
{

	public var mainfile(default, null) : String;
	
	public var width(default, null) : Int;

	public var height(default, null) : Int;
	
	public var itemWidth(default, null) : Int;

	public var itemHeight(default, null) : Int;
	
	public var animsData(default,null) : Array<SpriteSheetAnimData>;
	
	public function new(mainfile : String, w : Int, h : Int, iW : Int, iH : Int) 
	{
		this.mainfile = mainfile;
		animsData = new Array();
		width = w;
		height = h;
		itemWidth = iW;
		itemHeight = iH;
	}
	
	public function addAnim(data : SpriteSheetAnimData) : Void
	{
		animsData.push(data);
	}
	
	
}