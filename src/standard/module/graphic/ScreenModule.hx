package standard.module.graphic;

import core.module.Module;
import standard.components.graphic.display.impl.Layer;
import standard.group.graphic.display.ScreenGroup;

/**
 * ...
 * @author Breakyt
 */
class ScreenModule extends Module<ScreenGroup>
{

	private var m_layerRef : Layer;
	
	private var m_screens : Map<String, ScreenGroup>;
	
	private var m_previousScreen : ScreenGroup;
	
	private var m_currentScreen : ScreenGroup;
	
	public function new(layerRef : Layer) 
	{
		super(ScreenGroup);
		
		m_layerRef = layerRef;
		m_screens = new Map<String, ScreenGroup>();
		m_previousScreen = null;
		m_currentScreen = null;
	}
	
	override function onCompGroupAdded(group:ScreenGroup):Void 
	{
		m_screens.set(group.entityRef.name, group);
	}
	
	override function onCompGroupRemove(group:ScreenGroup):Void 
	{
		m_screens.remove(group.entityRef.name);
	}
	
	override function onAddedToApplication():Void 
	{
	}
	
	override function onRemoveFromApplication():Void 
	{
	}
	
	override public function update(delta:Float):Void 
	{
	}
	
	private function attachGroupToLayer(group : ScreenGroup)
	{
		if(group!=null && group.screen.skin !=null)
			m_layerRef.skin.addChild(group.screen.skin);
	}
	
	private function removeGroupToDisplayList(group : ScreenGroup)
	{
		if(group!=null && group.screen.skin != null && group.screen.skin.parent != null)
			group.screen.skin.parent.removeChild(group.screen.skin);
	}
	
	public function goToScreen(screenName : String = null, transitAtsameTime : Bool = true) : Void
	{
		if (screenName != null && m_currentScreen.entityRef.name  == screenName)
			return;
			
		if (screenName == null && m_currentScreen == null)
			return;
			
		if (m_previousScreen != null && m_previousScreen.opener !=null && m_previousScreen.opener.isOnTransit())
			return;
			
		if (m_currentScreen != null && m_previousScreen.opener != null && m_currentScreen.opener.isOnTransit())
			return;
		
		m_previousScreen = m_currentScreen;
		m_currentScreen = m_screens.get(screenName);
		
		if (m_previousScreen != null && m_previousScreen.opener != null)
		{
			m_previousScreen.opener.onClose = previousClosed.bind(transitAtsameTime);
			m_previousScreen.opener.close();
		}
		else
			previousClosed(transitAtsameTime);
			
		if (transitAtSametime)
			startOpenCurrentScreen();
			

	}
	
	private function previousClosed(transitAtSametime : Bool) : Void
	{
		if (m_previousScreen.screen.onClose != null)
			m_previousScreen.screen.onClose();
			
		
		this.removeGroupToDisplayList(m_previousScreen);
		
		if (!transitAtSametime)
			startOpenCurrentScreen();
	}
	
	private function startOpenCurrentScreen() : Void
	{
		if (m_currentScreen != null)
		{
			if (m_currentScreen.screen.onInit != null)
				m_currentScreen.screen.onInit;
			
			this.attachGroupToLayer(m_currentScreen);
			
			if ( m_currentScreen.opener != null)
			{
				m_currentScreen.opener.onOpen = currentOpen;
				m_currentScreen.opener.open();
			}
			else
				currentOpen();
		}		
	}
	
	private function currentOpen() : Void
	{
		if (m_currentScreen.screen.onOpen != null)
			m_currentScreen.screen.onOpen();
	}
	
	
}