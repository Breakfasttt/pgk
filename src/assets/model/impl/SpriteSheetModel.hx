package assets.model.impl;

import assets.model.library.ModelData;
import assets.model.Model;
import assets.tools.spritesheet.SpriteSheetAnimData;
import assets.tools.spritesheet.SpriteSheetData;
import flash.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.Assets;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class SpriteSheetModel extends Model 
{
	private var m_mainBitmapData : BitmapData;
	
	private var m_spriteSheetDatas : SpriteSheetData;
	
	public function new(modelData:ModelData) 
	{
		super(modelData);
	}
	
	override function prepare():Void 
	{
		
		var mainFile : String = getDataFromJson("main");
		var w : Int = getDataFromJson("width");
		var h : Int = getDataFromJson("height");
		var iw : Int = getDataFromJson("itemWidth");
		var ih : Int = getDataFromJson("itemHeight");
		m_spriteSheetDatas = new SpriteSheetData(mainFile, w , h, iw, ih);
		
		var allAnims : Array<Dynamic> = cast getDataFromJson("anims");
		
		for (anim in allAnims)
		{
			var pivots : Array<Vector2D> = new Array();
			var arrTemp : Array<Dynamic> = anim.pivots;
			
			for (pivot in arrTemp)
				pivots.push(new Vector2D(pivot.x, pivot.y));
			
			m_spriteSheetDatas.addAnim(new SpriteSheetAnimData(anim.name, anim.framerate, anim.startIndex, pivots));
		}
		
		try
		{
			m_mainBitmapData = Assets.getBitmapData(m_spriteSheetDatas.mainfile);
		}
		catch (e : Dynamic)
		{
			m_mainBitmapData = this.createSquare(m_spriteSheetDatas.width, m_spriteSheetDatas.height);
		}
		
		
		var xSheet : Float = 0.0;
		var ySheet : Float = 0.0;
		
		var point : Point = new Point();
		
		for (animData in m_spriteSheetDatas.animsData)
		{
			
			var step : Int = 0; 
			var arrBmp : Array<BitmapData> = new Array();
			var xIndex : Int = 0;
			var yIndex : Int = 0;
			
			step = Math.floor(m_spriteSheetDatas.width / m_spriteSheetDatas.itemWidth);


			for (i in 0...animData.framerate)
			{
				yIndex = Math.floor((animData.startindex + i) / step);
				xIndex = (animData.startindex + i) - yIndex * step;
				
				xSheet = xIndex * m_spriteSheetDatas.itemWidth;
				ySheet = yIndex * m_spriteSheetDatas.itemHeight;
				
				var frameBitmapData : BitmapData = new BitmapData(m_spriteSheetDatas.itemWidth, m_spriteSheetDatas.itemHeight, true);
				frameBitmapData.copyPixels(m_mainBitmapData, new Rectangle(xSheet, ySheet, m_spriteSheetDatas.itemWidth, m_spriteSheetDatas.itemHeight), point);
				
				arrBmp.push(frameBitmapData);
			}
			
			m_bmdByAnim.set(animData.name, arrBmp);
			m_offsetByAnim.set(animData.name, animData.pivots.copy());
			m_frameratesByAnim.set(animData.name, animData.framerate);
		}
		
		
		var firstFrame : BitmapData = new BitmapData(m_spriteSheetDatas.itemWidth, m_spriteSheetDatas.itemHeight, true);
		firstFrame.copyPixels(m_mainBitmapData, new Rectangle(0, 0, m_spriteSheetDatas.itemWidth, m_spriteSheetDatas.itemHeight), point);
		
		m_bmdByAnim.set(Model.firstFrameAnim, [firstFrame]);
		m_offsetByAnim.set(Model.firstFrameAnim, [new Vector2D()]);
		m_frameratesByAnim.set(Model.firstFrameAnim, 1);
	}
	
	
	
	
	private function getDataFromJson(field : String) : Dynamic
	{
		try
		{
			return Reflect.getProperty(this.modelData.jsonData, field);
		}
		catch (e : Dynamic)
		{
			return null;
		}
	}
	
}