package standard.utils.uicontainer.impl;

import core.Application;
import core.entity.Entity;
import standard.components.graphic.display.impl.PopUp;
import standard.components.graphic.transition.Opener;
import standard.components.graphic.transition.impl.ScaleTransitionEntity;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.factory.EntityFactory;
import standard.module.graphic.PopUpModule;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class PopupContainer extends UiContainer 
{

	private var m_modulePopupRef : PopUpModule;
	
	public var opener(default,null) : Opener;
	
	public function new(name:String, appRef:Application, entityFactory : EntityFactory) 
	{
		super(name, appRef, entityFactory);
		
		if(m_appRef != null)
			m_modulePopupRef = this.m_appRef.modManager.getModule(PopUpModule);
		
		this.display = new PopUp();
		this.entity.add(this.display);
		configure();
		createElement();
	}
	
	/**
	 * Override it if you want a specific configuration (like set the UtilitySize for exemple)
	 */
	private function configure() : Void
	{
		this.opener = new Opener(new ScaleTransitionEntity(10.0, 1.0, 1.0, false), new ScaleTransitionEntity(10.0, 1.0, 1.0, true));
		this.entity.add(this.opener);
		this.position.position2d = Anchor.center;
		this.pivot.pivot = Anchor.center;
	}
	
	/**
	 * Close this popup
	 */
	public function closePopup() : Void
	{
		if (m_modulePopupRef != null)
			m_modulePopupRef.closeLastPopup();
	}
	
}