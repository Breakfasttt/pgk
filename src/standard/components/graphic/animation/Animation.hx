package standard.components.graphic.animation;

import assets.model.Model;
import core.component.Component;
import lime.system.Display;
import msignal.Signal.Signal0;

/**
 * ...
 * @author Breakyt
 */
class Animation extends Component 
{
	public var modelRef(default, null) : Model;
	
	public var animEnded(default, null) : Signal0; 
	
	public var currentAnim(default, null) : String;
	
	public var currentFrame(default, null) : Int;
	
	public var currentMaxFrame(default, null) : Int;
	
	public var currentFrameRate(default, null) : Int;
	
	public var loop : Bool;
	
	public var rewind(default, set) : Bool;
	
	public var speedRatio : Float;
	
	public var playing(default, null) : Bool;
	
	private var m_needUpdate : Bool;
	
	private var m_progression : Float;
	
	private var m_sens : Float;
	
	public function new(modelRef : Model, startAnim : String = null) 
	{
		super();
		this.modelRef = modelRef;
		this.animEnded = new Signal0();
		
		loop = true;
		rewind = false;
		m_sens = 1.0;
		speedRatio = 1.0;
		
		startAnim = startAnim == null ? Model.firstFrameAnim : startAnim;
		setAnim(startAnim);
	}
	
	
	public function setAnim(animName : String, playNow : Bool = true) : Bool
	{
		if (this.modelRef == null)
			return false;
		else if (!this.modelRef.exists(animName))
			return false;
			
		currentAnim = animName;
		currentFrame = 0;
		m_progression = 0;
		currentMaxFrame = this.modelRef.getNbreFrame(currentAnim);
		currentFrameRate = this.modelRef.getAnimFrameRate(currentAnim);	
		
		if (playNow)
			play();
		else
			stop();
			
		return true;
	}
	
	public function play() : Void
	{
		currentFrame = 0;
		playing = true;
		m_needUpdate = true;
	}
	
	public function stop() : Void
	{
		currentFrame = 0;
		playing = false;
		m_needUpdate = false;
	}
	
	public function pause() : Void
	{
		playing = false;
		m_needUpdate = false;
	}
	
	public function resume() : Void
	{
		playing = true;
		m_needUpdate = true;
	}
	
	
	public function gotoAndPlay(frame : Int) : Void
	{
		currentFrame = frame;
		resume();
	}
	
	public function gotoAndStop(frame : Int) : Void
	{
		currentFrame = frame;
		pause();
	}
	
	override function update( dt:Float ) : Void 
	{
		if (!m_needUpdate)
			return;
			
		m_progression += (dt / 1000) * currentFrameRate * speedRatio * m_sens;
		
		if (m_progression < 0.0)
		{
			m_progression = loop ? currentMaxFrame : 0.0;
		}
		else if (m_progression >= currentMaxFrame)
		{
			m_progression = loop ? 0.0 : currentMaxFrame;
		}
		
		currentFrame = Math.floor(m_progression);
	}
	
	public function checkAnimEnded() : Void
	{
		if (!rewind && !loop && currentFrame == currentMaxFrame)
		{
			this.animEnded.dispatch();
		}
		else if (rewind && !loop && currentFrame == 0)
		{
			this.animEnded.dispatch();
		}
	}
	
	private function set_rewind(value:Bool):Bool 
	{
		rewind = value;
		m_sens = rewind ? -1.0 : 1.0;
		return rewind;
	}
	
	
}