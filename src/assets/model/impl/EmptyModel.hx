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
class EmptyModel extends Model 
{

	
	public function new() 
	{
		super("");
	}
	
	override function prepare():Void 
	{
		this.skin = new Sprite();
	}
	
	override function release():Void 
	{
		this.skin = null;
	}
	
	override public function delete():Void 
	{
		this.release();
	}
	
	override public function setModel(modelName:String):Void 
	{
		//not special effect for EmptyModel. 
	}
	
	override public function setAnim(animName : String):Void 
	{
		//not special effect for EmptyModel. 
	}
	
	override public function stop():Void 
	{
		//not special effect for EmptyModel. 
	}
	
	override public function play():Void 
	{
		//not special effect for EmptyModel. 
	}
	
	override public function update(dt:Float):Void 
	{
		//not special effect for EmptyModel. 
	}
	
}