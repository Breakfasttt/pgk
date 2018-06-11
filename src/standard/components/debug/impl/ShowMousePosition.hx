package standard.components.debug.impl;

import core.Application;
import core.entity.Entity;
import flash.display.DisplayObject;
import openfl.Lib;
import openfl.geom.Point;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;
import standard.components.debug.DebugComp;
import standard.components.graphic.display.impl.Layer;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.misc.ParentEntity;
import standard.components.space2d.Position2D;
import standard.factory.EntityFactory;
import standard.group.graphic.display.LayerGroup;
import standard.module.graphic.LayerModule;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class ShowMousePosition extends DebugComp 
{
	
	private var m_layerModuleRef : LayerModule;
	
	private var m_textEntity : Entity;
	
	private var m_textDisplay : TextDisplay;
	
	private var m_textPosition : Position2D;
	
	private var m_parentLayer : Entity;
	
	
	public function new(layerModuleRef : LayerModule) 
	{
		super();
		m_layerModuleRef = layerModuleRef;
	}
	
	override public function initWhenAdded(appRef : Application, layerEntityRef : Entity, entityFactoryRef : EntityFactory):Void 
	{
		if (m_textEntity == null)
		{
			m_parentLayer = layerEntityRef;
			m_textEntity = entityFactoryRef.createTextField("debug::ShowMousePosition", m_parentLayer, "", 0, Anchor.botLeft, Anchor.botLeft);
			m_textDisplay =  m_textEntity.getComponent(TextDisplay);
			m_textDisplay.setAutoSize(TextFieldAutoSize.LEFT);
			m_textDisplay.setFontSize(18);
			m_textDisplay.setMiscProperties(false, true, false, false, false, false);
			m_textDisplay.setTextColor(0x00ff00);
			m_textDisplay.setAlignment(TextFormatAlign.JUSTIFY);
			
			m_textPosition = m_textEntity.getComponent(Position2D);
			//m_textPosition.position2d.ratioMode = false;
		}
		else
		{
			
			var parent : ParentEntity = m_textEntity.getComponent(ParentEntity);
			
			if (parent == null)
				m_textEntity.add(new ParentEntity(layerEntityRef));
			else
				parent.setParent(layerEntityRef);
		}
		
		appRef.addEntity(m_textEntity);
	}
	
	override public function deleteWhenRemove(appRef : Application, layerEntityRef : Entity, entityFactoryRef : EntityFactory):Void 
	{
		appRef.removeEntity(m_textEntity);
	}
	
	override public function update(delta:Float):Void 
	{
		if (m_textDisplay == null)
			return;
		
		var layers : Array<LayerGroup> = m_layerModuleRef.getLayersGroup();
		
		if (layers == null || layers.length == 0)
			return;
		
		var resultTxt : String = "";
		var geomPoint : Point = null;
		var ratio : Point = null;
		var mousePos : Point = new Point();
		
		resultTxt += "Stage : " + Lib.current.stage.mouseX + "/" +  Lib.current.stage.mouseY  + " px \n";
		
		for (lay in layers)
		{
			geomPoint = lay.layer.skin.globalToLocal(new Point(Lib.current.stage.mouseX, Lib.current.stage.mouseY));
			ratio = new Point( Math.fround((geomPoint.x / lay.utilitySize.width)*100), Math.fround((geomPoint.y / lay.utilitySize.height)*100));
			resultTxt += lay.entityRef.name + " : " + geomPoint.x + "/" + geomPoint.y + " px (" + ratio.x + "/" + ratio.y + " % )\n";
			
			if (m_parentLayer.name == lay.entityRef.name)
				mousePos = geomPoint;
		}
		
		if (m_textDisplay != null)
		{
			m_textDisplay.text.text = resultTxt;
			//m_textPosition.position2d.setValue(mousePos.x, mousePos.y);
		}
	}
	
}