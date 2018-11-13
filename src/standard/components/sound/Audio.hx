package standard.components.sound;

import core.component.Component;
import msignal.Signal;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import tools.math.MathUtils;

/**
 * ...
 * @author Breakyt
 */
class Audio extends Component 
{

	/**
	 * Name of the audio
	 */
	public var name(default, null) : String;
	
	/**
	 * Type of the audio. By default : AudioType.misc
	 */
	public var audioType(default, null) : AudioType;
	
	private var m_sound : Sound;
	
	/**
	 * The sound channel used during sound playing
	 */
	private var m_soundChannel : SoundChannel;
	
	private var m_soundTransform : SoundTransform;
	
	public var played(default, null) : Signal1<Audio>;
	
	public var soundPosition(default, null) : Float;
	
	public var volume(get, set) : Float;
	
	private var m_currentVolume : Float;
	
	public var loop : Bool;
	
	public var isPlaying(default, null) : Bool;
	
	public var isPaused(default, null) : Bool;
	
	public var isMuted(default, null) : Bool;
	
	public function new(name : String, type : AudioType, flSound : Sound) 
	{
		super();
		this.name = name;
		
		if(type!=null)
			this.audioType = type;
		else
			this.audioType = AudioType.misc;
		
s		this.volume = 1.0;
		this.loop = false;
		this.isPlaying = false;
		this.isPaused = false;
		this.isMuted = false;
		
		m_sound = flSound;
		m_soundChannel = null;
		m_soundTransform = new SoundTransform(m_currentVolume);
		
		this.played = new Signal1<Audio>();
	}
	
	override public function delete():Void 
	{
		super.delete();
		
		stop();
		
		this.name = "";
		this.volume = 1.0;
		this.loop = false;
		m_soundChannel = null;
		m_soundTransform = null;
		m_sound = null;
		this.isPlaying = false;
		this.isPaused = false;
		this.played.removeAll();
		this.played = null;
	}
	
	
	public function play(position : Float = -1) : Bool
	{
		if (m_sound == null)
			return false;
			
		if (this.isPlaying && !isPaused)
			stop();
			
		if (position > 0)
			this.soundPosition = position;
			
		this.isPlaying = true;
		this.isPaused = false;
		
		m_soundChannel = m_sound.play(this.soundPosition, 0, m_soundTransform);
		
		if (m_soundChannel == null)
		{
			trace("Can't create a new soundChannel for audio [" + this.name + "]");
			this.loop = false;
			this.isPlaying = false;
			return false;
		}
		
		m_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundPlayed);
		return true;
	}
	
	private function soundPlayed(notUsed : Event) : Void
	{
		stop();
		if (this.loop)
		{
			play();
			return;
		}
		
		if (this.played != null)
			this.played.dispatch(this);
	}
	
	public function stop() : Void
	{
		if (!this.isPlaying)
			return;
			
		this.isPlaying = false;
		this.soundPosition = 0;
		
		if (m_soundChannel == null)
			return;
			
		m_soundChannel.stop();
		m_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundPlayed);
		
	}
	
	public function pause() : Void
	{
		if (this.isPaused)
			return;
		
		var tempPos : Float = 0.0;
		if (m_soundChannel != null)
			tempPos = m_soundChannel.position;
			
		this.stop();
		this.soundPosition = tempPos;
		this.isPaused = true;
	}
	
	public function resume() : Bool
	{
		if (!this.isPaused)
			return false;
			
		this.isPaused = false;
		return play(this.soundPosition);
	}
	
	public function mute() : Void
	{
		if (this.isMuted)
			return;
			
		this.isMuted = true;
		m_soundTransform.volume = 0;
		
		if (this.isPlaying && m_soundChannel != null)
			m_soundChannel.soundTransform = m_soundTransform;
		
	}
	
	public function unmute() : Void
	{
		if (!this.isMuted)
			return;
			//
		this.isMuted = false;
		
		if(m_soundTransform!=null)
			m_soundTransform.volume = m_currentVolume;
		
		if (this.isPlaying && m_soundChannel != null)
			m_soundChannel.soundTransform = m_soundTransform;
	}
	
	
	function get_volume():Float 
	{
		return m_currentVolume;
	}
	
	function set_volume(value:Float):Float 
	{
		m_currentVolume = MathUtils.clamp(value, 0.0, 1.0);
		
		if (!this.isMuted)
		{
			if(m_soundTransform!=null)
				m_soundTransform.volume = m_currentVolume;
				
			if (this.isPlaying && m_soundChannel != null)
				m_soundChannel.soundTransform = m_soundTransform;
		}
		
		return m_currentVolume;
	}
	
	
}