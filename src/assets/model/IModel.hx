package assets.model;
import assets.model.library.ModelData;
import flash.display.DisplayObjectContainer;
import openfl.display.BitmapData;
import tools.math.Vector2D;

/**
 * @author Breakyt
 */
interface IModel 
{
	public var modelData(default, null) : ModelData;
	
	private var m_frameratesByAnim :  Map<String, Int>;
	
	private var m_bmdByAnim : Map<String, Array<BitmapData>>;
	
	private var m_offsetByAnim :  Map<String, Array<Vector2D>>;
	
	private function prepare() : Void;
	
	public function delete() : Void;
	
	public function getAnims() : Array<String>;
	
	public function getBitmapData(frame : Int, anim : String = null) : BitmapData;
	
	public function getBitmapDataOffset(frame : Int, anim : String = null) : Vector2D;
	
	public function getFirstFrame() : BitmapData;
	
	public function getNbreFrame(anim : String = null) : Int;
	
	public function getAnimFrameRate(anim : String = null) : Int;
	
	public function exists(anim : String) : Bool; 
	
	
}