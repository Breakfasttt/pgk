package assets.model.impl;

import assets.model.Model;
import assets.model.library.ModelData;
import assets.model.library.ModelType;
import flash.display.BitmapData;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Breakyt
 */
class EmptyModel extends Model 
{
	public function new(name : String) 
	{
		super(new ModelData(name, "", ModelType.empty, ""));
	}
	
	override function prepare():Void 
	{
		m_bmdByAnim.set(Model.firstFrameAnim, new Array());
		m_frameratesByAnim.set(Model.firstFrameAnim, 1);
		m_maxWidth = 0.0;
		m_maxHeight = 0.0;
	}
	
}