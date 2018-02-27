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
	
	override function onAddedToApplication():Void 
	{
	}
	
	override function onCompGroupAdded(group:PopUpGroup):Void 
	{
		m_popupStack.push(group);
		showTop()
	}
	
	override function onCompGroupRemove(group:PopUpGroup):Void 
	{
		m_popupStack.remove(group);
		
		if (group == m_currentPopup)
		{
			if (m_currentPopup.popup.skin != null && m_currentPopup.popup.skin.parent != null)
				m_currentPopup.popup.skin.parent.removeChild(m_currentPopup.popup.skin);
				
			m_currentPopup = null;
		}
			
		showTop();
	}
	
	override public function update(delta:Float):Void 
	{
	}
	
	private function showTop() : Void
	{
		if (m_popupStack.length > 0 && m_currentPopup == m_popupStack[m_popupStack.length -1])
			return;
		
		if (m_currentPopup != null && m_currentPopup.popup.skin != null && m_currentPopup.popup.skin.parent != null)
			m_currentPopup.popup.skin.parent.removeChild(m_currentPopup.popup.skin);
		
		if(m_popupStack.length > 0)
			m_currentPopup = m_popupStack[m_popupStack.length -1];
		else
			m_currentPopup = null;
		
		if (m_currentPopup != null)
		{
			m_layerRef.skin.addChildAt(m_mask, 0);
			m_layerRef.skin.addChild(m_currentPopup.popup.skin);
		}
		else if(m_mask.parent != null)
			m_layerRef.skin.removeChild(m_mask);
	}
	
	private function createMask() : Void
	{
		m_mask = new Sprite();
		
		if ( m_layerRef == null ||  m_utilitySizeRef == null)
			return;
		
		m_mask.graphics.beginFill(0x000000, 0.45);
		m_mask.graphics.drawRect(0, 0, m_utilitySizeRef.width, m_utilitySizeRef.height);
		m_mask.graphics.endFill();
		//m_layerRef.skin.addChildAt(m_mask, 0);	
	}
	
	
}