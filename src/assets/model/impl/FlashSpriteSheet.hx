package assets.model.impl;

import assets.model.library.ModelData;
import assets.model.Model;
import assets.tools.spritesheet.FlashSpriteSheetFrame;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import tools.file.JsonTools;
import tools.file.PathTools;
import tools.math.Vector2D;
import tools.misc.SortFunc;

/**
 * ...
 * @author Breakyt
 */
class FlashSpriteSheet extends Model 
{

	private var m_mainBitmapData : BitmapData;
	
	public function new(modelData:ModelData) 
	{
		super(modelData);
	}
	
	override function prepare():Void 
	{
		if (this.modelData.jsonData == null)
		{
			m_mainBitmapData = this.createSquare(50, 50);
			
			m_maxWidth  = 50.0;
			m_maxHeight = 50.0;
			
			m_bmdByAnim.set(Model.firstFrameAnim, [m_mainBitmapData]);
			m_offsetByAnim.set(Model.firstFrameAnim, [new Vector2D()]);
			m_frameratesByAnim.set(Model.firstFrameAnim, 1);
			trace("Warning :: No Json description detected for model : " + this.modelData.name + " - Generate a 50*50 square for this model.");
			return;
		}
		
		var metaData : Dynamic = JsonTools.getData(this.modelData.jsonData, "meta");
		var framesData : Dynamic = JsonTools.getData(this.modelData.jsonData, "frames");
		var pngfilename : String = JsonTools.getData(metaData, "image");
		
		pngfilename = PathTools.getPath(this.modelData.mainResourcePath) + pngfilename;
		
		try
		{
			m_mainBitmapData = Assets.getBitmapData(pngfilename);
		}
		catch (e : Dynamic)
		{
			m_mainBitmapData = this.createSquare(50,50);
		}
		
		var allKey : Array<String> = [];
		var allFrame : Array<FlashSpriteSheetFrame> = [];
		
		if(framesData!=null)
			allKey = Reflect.fields(framesData);
			
		allKey.sort(SortFunc.ascendingString);
		
		
		var rawFrameData : Dynamic  = null;
		for (key in allKey)
		{
			try
			{
				rawFrameData = Reflect.getProperty(framesData, key);
				
				if (rawFrameData == null)
					continue;
				
				allFrame.push(new FlashSpriteSheetFrame(key, new Rectangle(rawFrameData.frame.x, rawFrameData.frame.y, rawFrameData.frame.w, rawFrameData.frame.h), 
															 new Rectangle(rawFrameData.spriteSourceSize.x, rawFrameData.spriteSourceSize.y, rawFrameData.spriteSourceSize.w, rawFrameData.spriteSourceSize.h), 
															 new Vector2D(rawFrameData.sourceSize.w, rawFrameData.sourceSize.h), 
															 rawFrameData.rotated, 
															 rawFrameData.trimmed));
			}catch (e : Dynamic)
			{
				trace("Can't extract data for frame : " + key + " in model : " + this.modelData.name);
				continue;
			}
		}
		
		var point : Point = new Point();
		var arrBmp : Array<BitmapData> = new Array();
		var arrPivot : Array<Vector2D> = new Array();
		
		for (frame in allFrame)
		{
			var frameBitmapData : BitmapData = new BitmapData( Std.int(frame.sourceSize.x), Std.int(frame.sourceSize.y), true);
			frameBitmapData.copyPixels(m_mainBitmapData, frame.frameRectangle, point);
			arrBmp.push(frameBitmapData);
			arrPivot.push(new Vector2D());
		}
		
		m_bmdByAnim.set(Model.defaultAnim, arrBmp);
		m_offsetByAnim.set(Model.defaultAnim, arrPivot);
		m_frameratesByAnim.set(Model.defaultAnim, arrBmp.length);
		
		
		var firstFrame : BitmapData = new BitmapData(Std.int(allFrame[0].sourceSize.x), Std.int(allFrame[0].sourceSize.y), true);
		firstFrame.copyPixels(m_mainBitmapData, allFrame[0].frameRectangle , point);
		
		m_bmdByAnim.set(Model.firstFrameAnim, [firstFrame]);
		m_offsetByAnim.set(Model.firstFrameAnim, [new Vector2D()]);
		m_frameratesByAnim.set(Model.firstFrameAnim, 1);
		
	}
	
}