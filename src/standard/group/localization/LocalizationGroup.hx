package standard.group.localization;

import core.component.ComponentGroup;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.localization.Localization;

/**
 * ...
 * @author Breakyt
 */
class LocalizationGroup extends ComponentGroup 
{

	public var textDisplay : TextDisplay;
	public var localization : Localization;
	
	public function new() 
	{
		super();
		
		this.bindFieldType(TextDisplay, 'textDisplay');
		this.bindFieldType(Localization, 'localization');
	}
	
}