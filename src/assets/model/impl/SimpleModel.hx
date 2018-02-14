package assets.model.impl;

import assets.model.Model;
import assets.model.library.ModelData;
import flash.display.BitmapData;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Breakyt
 */
class SimpleModel extends Model 
{

	public function new(modelData:ModelData) 
	{
		super(modelData);
	}
	
	override function prepare():Void 
	{
		var arr : Array<BitmapData> = [];
		try
		{
			arr.push( Assets.getBitmapData(this.modelData.mainResourcePath));
		}
		catch (e : Dynamic)
		{
			arr.push(this.createSquare());
			trace("Can't find ressource :" + this.modelData.mainResourcePath + " in assets for this model : " + this.modelData.name + ". Replace it with random color 50*50 square");
		}
		
		m_bmdByAnim.set(Model.firstFrameAnim, arr);
		m_offsetByAnim.set(Model.firstFrameAnim, new Array());
		m_frameratesByAnim.set(Model.firstFrameAnim, 1);
	}

}