package standard.utils.uicontainer.impl;

import core.Application;
import standard.components.localization.Localization;
import standard.factory.EntityFactory;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class LocTextButton extends TextButton 
{

	private var m_loc : Localization;
	
	public function new(name:String, appRef:Application, entityFactory:EntityFactory) 
	{
		super(name, appRef, entityFactory);
		
	}
	
	public function setLoc(keyword:String, textData : Array<Dynamic>)
	{
		this.textDisplay.text.text = keyword;
		
		if (m_loc == null)
		{
			m_loc = new Localization(keyword, textData);
			this.m_textEntity.add(m_loc);
		}
		else
			m_loc.set(keyword, textData);
			
		
	}
	
}