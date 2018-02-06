package assets.model.impl;

import assets.model.Model;
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

	private var m_bitmapDataRef : BitmapData;
	
	private var m_bitmap : Bitmap;
	
	
	public function new(modelName:String) 
	{
		super(modelName);
	}
	
	override function prepare():Void 
	{
		try
		{
			m_bitmapDataRef = Assets.getBitmapData(this.modelName);
			m_bitmap = new Bitmap(m_bitmapDataRef);
			this.skin = new Sprite();
			this.skin.addChild(m_bitmap);
		}
		catch (e : Dynamic)
		{
			this.skin = this.createSquare();
			trace("Can't find modelName :" + this.modelName + " in assets. Replace it with random color 50*50 square");
			
		}
	}
	
	override function release():Void 
	{
		this.skin.removeChild(m_bitmap);
		m_bitmap = null;
		m_bitmapDataRef = null;
		this.skin = null;
	}
	
	override public function delete():Void 
	{
		this.release();
	}
	
	override public function setModel(modelName:String):Void 
	{
		if (Assets.getBitmapData(modelName) == null)
		{
			trace("Can't set new model because not found on Asset : " + modelName);
			return;
		}
		
		super.setModel(modelName);
		release();
		prepare();
	}
	
	override public function setAnim(animName : String):Void 
	{
		//not special for SimpleModel. A simple model is a unique bitmap
	}
	
	override public function stop():Void 
	{
		//not special for SimpleModel. A simple model is a unique bitmap
	}
	
	override public function play():Void 
	{
		//not special for SimpleModel. A simple model is a unique bitmap
	}
	
	override public function update(dt:Float):Void 
	{
		//not special for SimpleModel. A simple model is a unique bitmap
	}
	
}