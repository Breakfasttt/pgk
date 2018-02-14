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
		this.skin = new Sprite();
	}
	
	override public function delete():Void 
	{
		this.skin = null;
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