package standard.components.debug.impl;
import core.Application;
import core.entity.Entity;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;
import standard.components.debug.DebugComp;
import standard.components.graphic.display.impl.TextDisplay;
import standard.factory.EntityFactory;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class ShowFps extends DebugComp
{

	private var m_appRef : Application;
	
	private var m_textEntity : Entity;
	
	private var m_textDisplay : TextDisplay;
	
	public function new() 
	{
		super();
	}
	
	override public function initWhenAdded(appRef : Application, layerEntityRef:Entity, entityFactoryRef:EntityFactory):Void 
	{
		m_appRef = appRef;
		
		if (m_textEntity == null)
		{
			m_textEntity = entityFactoryRef.createTextField("DebugComp::ShowFps", layerEntityRef, "", 0, Anchor.topLeft, Anchor.topLeft);
			m_textDisplay = m_textEntity.getComponent(TextDisplay);m_textDisplay =  m_textEntity.getComponent(TextDisplay);
			m_textDisplay.setAutoSize(TextFieldAutoSize.LEFT);
			m_textDisplay.setFontSize(18);
			m_textDisplay.setMiscProperties(false, true, true, false, false, false);
			m_textDisplay.setTextColor(0x00ff00);
			m_textDisplay.setAlignment(TextFormatAlign.LEFT);
		}
		
		m_appRef.addEntity(m_textEntity);
	}
	
	override public function deleteWhenRemove(appRef:Application, layerEntityRef:Entity, entityFactoryRef:EntityFactory):Void 
	{
		m_appRef.removeEntity(m_textEntity);
	}
	
	override public function update(delta:Float):Void 
	{
		m_textDisplay.text.text =  "" + Math.round(m_appRef.actualFps) + " fps";
	}
	
}