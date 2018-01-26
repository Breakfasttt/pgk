package standard.module.graphic;

import core.module.Module;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.utils.AssetType;
import standard.group.graphic.RepresentationGroup;
import tools.misc.Color;

/**
 * ...
 * @author Breakyt
 */
class RepresentationModule extends Module<RepresentationGroup>
{
	public function new() 
	{
		super(RepresentationGroup);
	}
	
	override function onCompGroupAdded(group:RepresentationGroup):Void 
	{
		if (group.display.layerMode)
		{
			trace("Warning : An Entity with Display Component set as a layer can't have a Representation Component. Operation Abort");
			return;
		}
		
		setRepresentationToDisplay(group);
		group.representation.pathChange.add(setRepresentationToDisplay.bind(group));
	}
	
	override function onCompGroupRemove(group:RepresentationGroup):Void 
	{
		if (group.display.layerMode)
		{
			trace("Warning : An Entity with Display Component set as a layer can't have a Representation Component. Operation Abort");
			return;
		}
		
		removeRepresentation(group);
		group.representation.pathChange.removeAll();
	}
	
	override public function update(delta:Float):Void 
	{
		//nothing special
	}
	
	private function removeRepresentation(group : RepresentationGroup) : Void
	{
		if (group.display.container.numChildren != 0)
			group.display.container.removeChildren();
	}
	
	private function setRepresentationToDisplay(group : RepresentationGroup) : Void
	{
		removeRepresentation(group);
		
		if (!Assets.exists(group.representation.assetsPath, AssetType.IMAGE))
		{
			trace("Warning : Can't find " + group.representation.assetsPath + " for entity : " + group.entityRef.name + ". A Random Colored Square 50*50 is created for this representation");
			group.display.container.addChild(createRedSquare());
		}
		else
		{
			//todo => manage many type of reprentation (animation, bitmap, movieclip, etc)
			var bmd : BitmapData = Assets.getBitmapData(group.representation.assetsPath);
			
			if (bmd != null)	
			{
				var bm : Bitmap = new Bitmap(bmd);
				group.display.container.addChild(bm);
			}
		}
	}
	
	private function createRedSquare() : Sprite
	{
		
		var result : Sprite = new Sprite();
		result.graphics.beginFill(Color.randomColor());
		result.graphics.drawRect(0, 0, 50, 50);
		result.graphics.endFill();
		return result;
	}
	
}