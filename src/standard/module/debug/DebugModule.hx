package standard.module.debug;
import core.module.Module;
import openfl.Lib;
import openfl.text.TextField;
import standard.group.debug.DebugGroup;

/**
 * 
 * @author Breakyt
 */
class DebugModule extends Module<DebugGroup>
{

	//temporary, need to remove this
	private var m_fpsTF : TextField;
	
	public function new() 
	{
		super(DebugGroup);
		m_fpsTF = new TextField();
		m_fpsTF.textColor = 0xff0000;
		m_fpsTF.width = 300;
		m_fpsTF.height = 50;
		m_fpsTF.mouseEnabled = false;
	}
	
	override function onAddedToApplication():Void 
	{
		Lib.current.stage.addChild(m_fpsTF);
	}	
	
	override function onRemoveFromApplication():Void 
	{
		Lib.current.stage.removeChild(m_fpsTF);
	}
	
	override public function update(delta:Float):Void 
	{
		m_fpsTF.text = "" + Math.round(m_appRef.actualFps);
	}
}