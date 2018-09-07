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
		this.scale.scale.set(scaleX, scaleY);
		
		m_btnEntity = this.m_entityFactoryRef.createSimpleBtn(this.entity.name + "::btn", this.entity, modelName, 0, Anchor.topLeft, Anchor.topLeft, onSelect, onUnSelect, onRollOver, onRollOut);
		
		this.utilitySize.autoUtilitySize = false;
		this.utilitySize.width = m_btnEntity.getComponent(Animation).modelRef.getMaxWidth();
		this.utilitySize.height = m_btnEntity.getComponent(Animation).modelRef.getMaxHeight();
		
		m_textEntity = this.m_entityFactoryRef.createTextField(this.entity.name + "::tf", this.entity, text, 1, Anchor.center, Anchor.center, null);
		textDisplay = m_textEntity.getComponent(TextDisplay);
		textDisplay.setFontSize(48);
		textDisplay.setAlignment(TextFormatAlign.CENTER);
		textDisplay.setAutoSize(TextFieldAutoSize.NONE);
		textDisplay.setSize(this.utilitySize.width, this.utilitySize.height - 10); //todo => remove hardcode
		textDisplay.setMiscProperties(false, false, false, false, false, false);
		textDisplay.setMouseEnable(false, false);
		
		this.add(m_btnEntity);
		this.add(m_textEntity);
	}
	
	
}