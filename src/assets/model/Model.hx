package assets.model;
import assets.model.library.ModelData;
import flash.display.DisplayObjectContainer;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import tools.math.Vector2D;
import tools.misc.Color;

/**
 * ...
 * @author Breakyt
 */
class Model implements IModel 
{

	public static var firstFrameAnim(default, null) : String = "firstFrameAnim";
	
	private var m_frameratesByAnim :  Map<String, Int>;
	
	public var modelData(default, null) : ModelData;
	
	private var m_bmdByAnim : Map<String, Array<BitmapData>>;
	
	private var m_offsetByAnim :  Map<String, Array<Vector2D>>;
	
	private var m_maxWidth : Float;
	
	private var m_maxHeight : Float;
	
	public function new(modelData : ModelData) 
	{
		this.modelData = modelData;
		m_frameratesByAnim = new Map();
		m_bmdByAnim = new Map();
		m_offsetByAnim = new Map();
		m_maxWidth = 0.0;
		m_maxHeight = 0.0;
		this.prepare();
	}	
	
	function prepare():Void 
	{
		trace("Model:: prepare() must be override");
	}
	
	public function delete():Void 
	{
		for (key in m_bmdByAnim.keys())
		{
			var arr = m_bmdByAnim.get(key);
			if (arr == null)
				continue;
				
			arr.splice(0, arr.length);
		}
		
		m_bmdByAnim = new Map();
		m_frameratesByAnim = new Map();
	}
	
	public function exists(anim : String) : Bool
	{
		return m_bmdByAnim.exists(anim);
	}
	
	public function getAnims():Array<String> 
	{
		var result : Array<String> = new Array<String>();
		
		for (key in m_bmdByAnim.keys())
			result.push(key);
		
		return result;
	}
	
	public function getAnimFrameRate(anim : String = null) : Int
	{
		return m_frameratesByAnim.get(anim);
	}
	
	public function getNbreFrame(anim : String = null) : Int
	{
		anim = anim == null ? Model.firstFrameAnim : anim;
		
		if (!m_bmdByAnim.exists(anim))
			return -1;
			
		if (m_bmdByAnim.get(anim) == null)
			return -1;
			
		return m_bmdByAnim.get(anim).length;
	}
	
	public function getFirstFrame() : BitmapData
	{
		return this.getBitmapData(1, Model.firstFrameAnim);
	}
	
	public function getBitmapData(frameIndex : Int, anim : String = null) : BitmapData
	{
		anim = anim == null ? Model.firstFrameAnim : anim;
		
		var frames : Array<BitmapData> = m_bmdByAnim.get(anim);
		
		if (frames == null || frames.length == 0)
			return null;
			
		if (frameIndex >= frames.length)
			frameIndex = frames.length - 1;
			
		return frames[frameIndex];
	}
	
	public function getBitmapDataOffset(frameIndex : Int, anim : String = null) : Vector2D
	{
		anim = anim == null ? Model.firstFrameAnim : anim;
		
		var frames : Array<Vector2D> = m_offsetByAnim.get(anim);
		
		if (frames == null || frames.length == 0)
			return Vector2D.origin;
			
		if (frameIndex >= frames.length)
			return Vector2D.origin;
			
		return frames[frameIndex];
	}
	
	/**
	 * Usefull function to create a square when a Display doesn't exist or can't be created.
	 * @return Sprite
	 */
	private function createSquare(w : Int = 50, h : Int = 50, color : Null<UInt> = null) : BitmapData
	{
		if (color == null)
			color = Color.randomColor();
		
		var result : BitmapData = new BitmapData(w,h,false,color);
		result.fillRect(new Rectangle(0, 0, w, h), color);
		return result;
	}	
	
	public function getMaxWidth() : Float
	{
		return m_maxWidth;
	}
	
	public function getMaxHeight() : Float
	{
		return m_maxHeight;
	}
	
}