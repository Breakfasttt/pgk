package standard.utils.uicontainer.impl;

import core.Application;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.transition.Opener;
import standard.components.graphic.transition.impl.SwapEntityTransition;
import standard.factory.EntityFactory;
import standard.module.graphic.ScreenModule;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class ScreenContainer extends UiContainer 
{

	private var m_moduleScreenRef : ScreenModule;
	
	public var opener(default,null) : Opener;
	
	public function new(name:String, appRef:Application, entityFactory:EntityFactory) 
	{
		super(name, appRef, entityFactory);
		
		if(m_appRef != null)
			m_moduleScreenRef = this.m_appRef.modManager.getModule(ScreenModule);
		
		this.display = new Screen();
		this.entity.add(this.display);
		configure();
		createElement();
		
	}
	
		/**
	 * Override it if you want a specific configuration (like set the UtilitySize for exemple)
	 */
	private function configure() : Void
	{
		//Todo améliorer ça, c'est pas top
		this.utilitySize.autoUtilitySize = false;
		this.opener = new Opener(new SwapEntityTransition(m_appRef.width), new SwapEntityTransition(null,-m_appRef.width));
		this.entity.add(this.opener);
		
		this.position.position2d.ratioMode = false;
		this.position.position2d.anchor.set(0,0);
		
		this.pivot.pivot = Anchor.topLeft;
	}
	
}