package standard.utils.uicontainer.impl;

import core.Application;
import standard.components.graphic.display.impl.Screen;
import standard.components.graphic.transition.Opener;
import standard.components.graphic.transition.impl.EntityTransition;
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
	
	private var m_opener(default, null) : Opener;
	
	private var m_transitionSwapped : Bool;
	private var m_openTransition : EntityTransition;
	private var m_closeTransition : EntityTransition;
	
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
		this.m_transitionSwapped = false;
		this.m_openTransition = new SwapEntityTransition(m_appRef.width);
		this.m_closeTransition = new SwapEntityTransition(null, -m_appRef.width);
		this.m_opener = new Opener(m_openTransition, m_closeTransition);
		this.entity.add(this.m_opener);
		
		cast(this.display, Screen).onInit = onScreenInit;
		cast(this.display, Screen).onOpen = onScreenOpen;
		cast(this.display, Screen).onClose = onScreenClose;
		
		this.position.position2d.ratioMode = false;
		this.position.position2d.anchor.set(0,0);
		
		this.pivot.pivot = Anchor.topLeft;
	}
	
	private function onScreenInit() : Void
	{
		//make other stuff ?
		onCustomScreenInit(); 
	}
	
	private function onScreenOpen() : Void
	{
		//make other stuff ?
		onCustomScreenOpen();
	}
	
	private function onScreenClose() : Void
	{
		//make other stuff ?
		onCustomScreenClose();
	}
	
	/**
	 * Call when screen is init (just before the opener start and "open" the screen with the transition to render it)
	 * override it
	 */
	private function onCustomScreenInit() : Void
	{
		
	}
	
	/**
	 * Call when the screen is open (just after the opener ended the "open" transition)
	 * override it
	 */
	private function onCustomScreenOpen() : Void
	{
		
	}
	
	/**
	 * Call when the screen is "close" (remove from the app) . Just after the opener ended the "close" transtion
	 * overrideIt
	 */
	private function onCustomScreenClose() : Void
	{
		
	}
	
}