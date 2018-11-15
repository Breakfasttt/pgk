package standard.utils.uicontainer.impl;

import core.Application;
import core.entity.Entity;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.components.space2d.Depth;
import standard.components.space2d.Position2D;
import standard.components.space2d.UtilitySize2D;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class TextButton extends Button 
{

	private var m_textEntity : Entity;
	
	public var textDisplay(default,null) : TextDisplay;
	
	
	public function new(name:String, appRef:Application, entityFactory:EntityFactory) 
	{
		super(name, appRef, entityFactory);
	}
	
	override function createElement():Void 
	{
		//not now
	}
	
	public function initText(text : String) : Void
	{
		m_textEntity = this.m_entityFactoryRef.createTextField(this.entity.name + "::tf", this.entity, text, 1, Anchor.center, Anchor.center, null);
		textDisplay = m_textEntity.getComponent(TextDisplay);
		textDisplay.setFontSize(48);
		textDisplay.setAlignment(TextFormatAlign.CENTER);
		textDisplay.setAutoSize(TextFieldAutoSize.NONE);
		textDisplay.setSize(this.utilitySize.width, this.utilitySize.height - 10); //todo => remove hardcode
		textDisplay.setMiscProperties(false, false, false, false, false, false);
		textDisplay.setMouseEnable(false, false);
		this.add(m_textEntity);
	}
	
}