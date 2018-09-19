package standard.module.graphic;

import core.entity.Entity;
import core.module.Module;
import openfl.display.Sprite;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.Layer;
import standard.components.space2d.Pivot2D;
import standard.components.space2d.Position2D;
import standard.components.space2d.Scale2D;
import standard.components.space2d.UtilitySize2D;
import standard.group.graphic.display.PopUpGroup;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class PopUpModule extends Module<PopUpGroup>
{

	private var m_layerRef : Layer;
	
	private var m_utilitySizeRef : UtilitySize2D;
	
	private var m_mask : Sprite;
	
	private var m_popupStack : Array<PopUpGroup>;
	
	private var m_currentPopup : PopUpGroup;
	
	public function new(layerRef : Layer, utilitySizeRef : UtilitySize2D) 
	{
		super(PopUpGroup);
		m_layerRef = layerRef;
		m_utilitySizeRef = utilitySizeRef;
		
		m_popupStack = new Array<PopUpGroup>();
		m_currentPopup = null;
		
		createMask();
	}
	
	override function onAddedToApplication():Void 
	{
	}
	
	override function onRemoveFromApplication():Void 
	{
		
	}
	
	override function onCompGroupAdded(group:PopUpGroup):Void 
	{
		
		if (group.opener != null)
			group.opener.setEntityRef(group.entityRef);
		
		m_popupStack.push(group);
		showNext();
	}
	
	override function onCompGroupRemove(group:PopUpGroup):Void 
	{
		//nothing special
	}
	
	override public function update(delta:Float):Void 
	{
		for (group in m_compGroups)
		{
			if (group.opener != null )
				group.opener.update(delta);
		}
	}
	
	private function showNext() : Void
	{
		closeCurrentPopup();
	}
	
	private function closeCurrentPopup() : Void
	{
		if (m_currentPopup != null && m_currentPopup.opener != null)
		{
			m_currentPopup.opener.onClose = onClose;
			m_currentPopup.opener.close();
		}
		else
			onClose();
		
	}
	
	private function onClose() : Void
	{
		if (m_currentPopup != null)
		{
			if(m_currentPopup.popup.skin != null && m_currentPopup.popup.skin.parent != null)
				m_currentPopup.popup.skin.parent.removeChild(m_currentPopup.popup.skin);
			
			if (m_currentPopup.opener != null)
			{
				//to prevent adding a popup when another are ine transition.
				// we finish the transition "silently"
				m_currentPopup.opener.onClose = null;
				m_currentPopup.opener.onOpen = null;
			}
			
			if (m_currentPopup.popup.onClose != null)
				m_currentPopup.popup.onClose();
			
			m_appRef.removeEntity(m_currentPopup.entityRef);
			m_popupStack.remove(m_currentPopup);
			m_currentPopup = null;
		}
		
		openLastPopup();
	}
	
	private function openLastPopup() : Void
	{
		if(m_popupStack.length > 0)
			m_currentPopup = m_popupStack[m_popupStack.length -1];
		else
			m_currentPopup = null;
			
		if (m_currentPopup != null)
		{
			
			if (m_currentPopup.popup.onInit != null)
				m_currentPopup.popup.onInit();
			
			m_layerRef.skin.addChildAt(m_mask, 0);
			m_layerRef.skin.addChild(m_currentPopup.popup.skin);
			
			if (m_currentPopup.opener != null)
			{
				m_currentPopup.opener.onOpen = onOpen;
				m_currentPopup.opener.open();
			}
			else
				onOpen();
		}
		else if(m_mask.parent != null)
			m_layerRef.skin.removeChild(m_mask);
	}
	
	private function onOpen() : Void
	{
		if (m_currentPopup.popup.onOpen != null)
			m_currentPopup.popup.onOpen();
		
	}
	
	private function createMask() : Void
	{
		m_mask = new Sprite();
		
		if ( m_layerRef == null ||  m_utilitySizeRef == null)
			return;
		
		m_mask.graphics.beginFill(0x000000, 0.20);
		m_mask.graphics.drawRect(0, 0, m_utilitySizeRef.width, m_utilitySizeRef.height);
		m_mask.graphics.endFill();
		//m_layerRef.skin.addChildAt(m_mask, 0);	
	}
	
	public function closeLastPopup() : Void
	{
		showNext();
	}
	
	
}