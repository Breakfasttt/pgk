package standard.components.graphic.display.impl;

import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import standard.components.graphic.display.Display;

/**
 * A text display is a GameElementDisplay who have a textField. 
 * It's more preferable to don't add an UtilitySize on a entity who hace this components
 * @author Breakyt
 */
class TextDisplay extends GameElementDisplay 
{

	private var m_textformat : TextFormat;
	
	public var text(default, null) : TextField;
	
	public function new(initText : String = "") 
	{
		super(null);
		this.text =  new TextField();
		m_textformat = new TextFormat();
		this.text.text = initText;
		this.skin.addChild(this.text);
	}
	
	private function setFormat() : Void
	{
		this.text.setTextFormat(m_textformat);
		this.text.defaultTextFormat = m_textformat;
	}
	
	public function setFontSize(size : Null<Int>) : Void
	{
		m_textformat.size = size;
		this.setFormat();
	}
	
	public function setFont(fontName : String, embedFont : Bool = true)
	{
		this.text.embedFonts = embedFont;
		m_textformat.font = fontName;
		this.setFormat();
	}
	
	public function setTextColor(color : Null<Int>) : Void
	{
		m_textformat.color = color;
		this.setFormat();
	}
	
	public function setProperties(bold : Null<Bool>, italic : Null<Bool>, underline : Null<Bool>) : Void
	{
		m_textformat.bold = bold;
		m_textformat.italic = italic;
		m_textformat.underline = underline;
		this.setFormat();
	}
	
	public function setAlignment(align : TextFormatAlign) 
	{
		m_textformat.align = align;
		this.setFormat();
	}
	
	public function setMargin(leftMargin : Null<Int>, rightMargin : Null<Int>, indent : Null<Int>, leading : Null<Int>) : Void
	{
		m_textformat.leftMargin = leftMargin;
		m_textformat.rightMargin = rightMargin;
		m_textformat.indent = indent;
		m_textformat.leading = leading;
		this.setFormat();
	}
	
	public function setUrl(url : String, target : String)
	{
		m_textformat.url = url;
		m_textformat.target = target;
		this.setFormat();
	}
	
	public function setSize(w : Float, h : Float) : Void
	{
		this.text.width = w;
		this.text.height = h;
	}
	
	public function setAutoSize(autoSize : TextFieldAutoSize) : Void
	{
		this.text.autoSize = autoSize;
	}
	
	public function setMiscProperties(selectable : Bool, multiline : Bool, worldwrap : Bool, mouseEnable : Bool, mouseWheelEnable : Bool, displayAsPassword : Bool) : Void
	{
		this.text.selectable = selectable;
		this.text.multiline = multiline;
		this.text.mouseEnabled = mouseEnable;
		this.text.mouseWheelEnabled = mouseWheelEnable;
		this.text.wordWrap = worldwrap;
		this.text.displayAsPassword = displayAsPassword;
	}
	
}