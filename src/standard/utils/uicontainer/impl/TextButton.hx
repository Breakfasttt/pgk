package standard.utils.uicontainer.impl;

import core.Application;
import core.entity.Entity;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.graphic.display.impl.TextDisplay;
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
class TextButton extends UiContainer 
{

	private var m_btnEntity : Entity;
	
	private var m_textEntity : Entity;
	
	public var textDisplay(default,null) : TextDisplay;
	
	public var depth(default,null) : Depth;
	
	public function new(name:String, appRef:Application, entityFactory:EntityFactory) 
	{
		super(name, appRef, entityFactory);
		
		this.display = new GameElementDisplay(null);
		this.depth = new Depth(0.0);
		
		this.entity.add(this.display);
		this.entity.add(this.depth);
	}
	
	override function createElement():Void 
	{
		//not now
	}
	
	public function init(text : String, modelName : String, depth : Float,
										position : Anchor, pivot : Anchor, 
										onSelect : Void->Void = null,
										onUnSelect : Void->Void  = null,
										onRollOver : Void->Void  = null,
										onRollOut : Void->Void  = null,
										scaleX : Float = 1.0, scaleY : Float = 1.0) : Void
	{
		
		
		this.position.position2d = position;
		this.pivot.pivot = pivot;
		this.depth.depth = depth;
		
		m_btnEntity = this.m_entityFactoryRef.createSimpleBtn(this.entity.name + "::btn", this.entity, modelName, 0, Anchor.center, Anchor.center, onSelect, onUnSelect, onRollOver, onRollOut, scaleX, scaleY);
		
		m_textEntity = this.m_entityFactoryRef.createTextField(this.entity.name + "::tf", m_btnEntity, text, 1, new Anchor(0.5,0.6), Anchor.center, null, scaleX, scaleY);
		textDisplay = m_textEntity.getComponent(TextDisplay);
		textDisplay.setFontSize(48);
		textDisplay.setAlignment(TextFormatAlign.CENTER);
		textDisplay.setAutoSize(TextFieldAutoSize.NONE);
		textDisplay.setMiscProperties(false, false, false, false, false, false);
		
		var btnUS : UtilitySize2D = m_btnEntity.getComponent(UtilitySize2D);
		textDisplay.setSize(btnUS.width, btnUS.height);
		
		//only add the btn because textDisplay is children of the button display
		m_appRef.addEntity(m_textEntity);
		this.add(m_btnEntity);
		
	}
	
	
}