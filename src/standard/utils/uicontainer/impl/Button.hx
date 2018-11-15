package standard.utils.uicontainer.impl;

import core.Application;
import core.entity.Entity;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.components.space2d.Depth;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class Button extends UiContainer 
{

	private var m_btnEntity : Entity;
	
	public var animationComp(default, null) : Animation;
	
	public var btnBehaviour(default,null) : EntityAsSimpleButton;
	
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
	
	public function init(	modelName : String,
							depth : Float,
							position : Anchor, 
							pivot : Anchor, 
							onSelect : Void->Void = null,
							onUnSelect : Void->Void  = null,
							onRollOver : Void->Void  = null,
							onRollOut : Void->Void  = null,
							scaleX : Float = 1.0, 
							scaleY : Float = 1.0) : Void
	{
		
		this.position.position2d = position;
		this.pivot.pivot = pivot;
		this.depth.depth = depth;
		this.scale.scale.set(scaleX, scaleY);
		
		m_btnEntity = this.m_entityFactoryRef.createSimpleBtn(this.entity.name + "::btn", this.entity, modelName, 0, Anchor.topLeft, Anchor.topLeft, onSelect, onUnSelect, onRollOver, onRollOut);
		
		this.utilitySize.autoUtilitySize = false;
		this.animationComp = m_btnEntity.getComponent(Animation);
		this.utilitySize.width = this.animationComp.modelRef.getMaxWidth();
		this.utilitySize.height = this.animationComp.modelRef.getMaxHeight();
		
		var comp : PointerBehavioursComponent = m_btnEntity.getComponent(PointerBehavioursComponent);
		this.btnBehaviour = cast(comp.getBehav(0), EntityAsSimpleButton);
		
		this.add(m_btnEntity);
	}
	
	public function setEnable(enable : Bool) : Void
	{
		if (this.btnBehaviour != null)
			this.btnBehaviour.setEnable(enable);
	}
	
}