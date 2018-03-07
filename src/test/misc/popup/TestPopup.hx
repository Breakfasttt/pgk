package test.misc.popup;

import core.Application;
import core.entity.Entity;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.Display;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.impl.PopupContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class TestPopup extends PopupContainer 
{

	private var m_background : Entity;
	private var m_closeButton : Entity;
	
	private var m_btnBehav : EntityAsSimpleButton;
	
	public function new(appRef:Application, entityFactory:EntityFactory) 
	{
		super("testPopup", appRef, entityFactory);
	}
	
	override function configure():Void 
	{
		super.configure();
	}
	
	override function createElement():Void 
	{
		m_background = this.m_entityFactoryRef.createGameElement("testPopup_bg", null, "spritesheet1", 0, Anchor.center, Anchor.center, "walk-back");
		m_closeButton = this.m_entityFactoryRef.createGameElement("testPopup_closeBtn", null, "timeline1", 1, Anchor.topRight, Anchor.topRight);
		
		try
		{
			m_background.getComponent(Animation).useAnimationPivot = false;
			m_closeButton.getComponent(Animation).useAnimationPivot = false;
		}
		catch (e : Dynamic)
		{
			//osef
		}
		
		m_btnBehav = new EntityAsSimpleButton(false);
		m_btnBehav.setEntityRef(m_closeButton);
		m_btnBehav.onSelect = onClose;
		
		this.utilitySize.autoUtilitySize = false;
		this.utilitySize.width = 100.0;
		this.utilitySize.height = 100.0;
		//this.utilitySize.setUtilitySizeBySkin(m_background.getComponent(Display).skin);
		
		this.add(m_background);
		this.add(m_closeButton);
		
		
	}
	
	private function onClose() : Void
	{
		this.closePopup();
	}
	
}