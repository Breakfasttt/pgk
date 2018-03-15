package standard.components.graphic.display.impl;

import openfl.text.TextField;
import standard.components.graphic.display.Display;

/**
 * A text display is a GameElementDisplay who have a textField. 
 * It's more preferable to don't add an UtilitySize on a entity who hace this components
 * @author Breakyt
 */
class TextDisplay extends GameElementDisplay 
{

	public var text(default, null) : TextField;
	
	public function new(initText : String = "") 
	{
		super(null);
		this.text =  new TextField();
		this.text.text = initText;
		this.skin.addChild(this.text);
	}
	
}