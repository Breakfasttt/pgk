package assets.model.impl;

import assets.model.library.ModelData;
import assets.model.Model;
import flash.display.BitmapData;
import openfl.Assets;
import tools.file.JsonTools;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class TimelineModel extends Model 
{

	public function new(modelData:ModelData) 
	{
		super(modelData);
		
	}
	
	override function prepare():Void 
	{
		var ressouces : Array<BitmapData> = new Array<BitmapData>();
		var ressourcesName : Array<String> = cast JsonTools.getData(this.modelData.jsonData, "ressources");
		var animsData : Array<Dynamic> = cast JsonTools.getData(this.modelData.jsonData, "anims");
		
		for (resName in ressourcesName)
		{
			if (!Assets.exists(resName))
			{
				trace("WARNING :: Can't find assets : " + resName + " for timeline model : " + this.modelData.name + ". Replaced by a generate 50*50 square");
				ressouces.push(this.createSquare());
				continue;
			}
			
			ressouces.push(Assets.getBitmapData(resName));
		}
		
		if (ressouces.length == 0)
			ressouces.push(this.createSquare());
		
		for (anim in animsData)
		{
			var ressourceForAnim : Array<BitmapData> = new Array<BitmapData>();
			var offsets : Array<Vector2D> = new Array<Vector2D>(); //todo
			
			var frames : Array<Int> = cast anim.frames;
			
			for (frame in frames)
			{
				if (frame < 0 || frame > ressouces.length -1)
				{
					trace("WARNING :: Invalid frame number for timeline model : " + this.modelData + " for anim : " + anim.name);
					continue;
				}
				
				ressourceForAnim.push(ressouces[frame]);
				offsets.push(Vector2D.origin); // todo
			}
			
			
			m_bmdByAnim.set(anim.name, ressourceForAnim);
			m_frameratesByAnim.set(anim.name, ressourceForAnim.length);
			m_offsetByAnim.set(anim.name, offsets); //todo
		}
		
		
		m_bmdByAnim.set(Model.firstFrameAnim, [ressouces[0]]);
		m_frameratesByAnim.set(Model.firstFrameAnim, 1);
		m_offsetByAnim.set(Model.firstFrameAnim, [Vector2D.origin]); //todo
		
	}
	
}