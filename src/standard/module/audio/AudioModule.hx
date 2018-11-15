package standard.module.audio;

import core.module.Module;
import openfl.media.SoundMixer;
import openfl.media.SoundTransform;
import standard.components.audio.AudioType;
import standard.group.audio.AudioGroup;
import tools.math.MathUtils;

/**
 * ...
 * @author Breakyt
 */
class AudioModule extends Module<AudioGroup>
{
	
	public var globalVolume(default, set) : Float;
	
	private var m_globalSF : SoundTransform;
	
	private var m_volumeByType : Map<AudioType, Float>;
	private var m_muteByType : Map<AudioType, Bool>;
	private var m_allMuted : Bool;
	
	public function new() 
	{
		super(AudioGroup);
		
		var allAudioTypes : Array<AudioType> = Type.allEnums(AudioType);
		m_volumeByType = new Map();
		m_muteByType = new Map();
		m_allMuted = false;
		
		for (type in allAudioTypes)
		{
			m_volumeByType.set(type, 1.0);
			m_muteByType.set(type, false);
		}
		m_globalSF = new SoundTransform();
		this.globalVolume = 1.0;
		
	}
	
	override function onCompGroupAdded(group:AudioGroup):Void 
	{
		var volume = m_volumeByType.get(group.audio.audioType);
		group.audio.volume = volume;
	}
	
	override function onCompGroupRemove(group:AudioGroup):Void 
	{
		
	}
	
	override public function update(delta:Float):Void 
	{
		
	}
	
	function get_globalVolume():Float 
	{
		return globalVolume;
	}
	
	function set_globalVolume(value:Float):Float 
	{
		globalVolume = MathUtils.clamp(value, 0.0, 1.0);
		m_globalSF.volume = globalVolume;
		SoundMixer.soundTransform = m_globalSF;
		return globalVolume;
	}
	
	public function addGlobalVolume(delta : Float) : Void
	{
		this.globalVolume = this.globalVolume + delta;
	}
	
	public function setTypeVolume(audioType : AudioType, volume : Float)
	{
		m_volumeByType.set(audioType, volume);
		
		for (group in m_compGroups)
		{
			if(group.audio.audioType == audioType)
				group.audio.volume = volume;
		}
		
	}
	
	public function addTypeVolume(audioType : AudioType, delta : Float)
	{
		var newVolume : Float = 0.0;
		newVolume = m_volumeByType.get(audioType) + delta;
		newVolume = MathUtils.clamp(newVolume, 0.0, 1.0);
		m_volumeByType.set(audioType, newVolume);
		
		for (group in m_compGroups)
		{
			if(group.audio.audioType == audioType)
				group.audio.volume = newVolume;
		}
	}
	
	public function getTypeVolume(audioType : AudioType) : Float
	{
		return m_volumeByType.get(audioType);
	}
	
	public function muteType(audioType : AudioType)
	{
		m_muteByType.set(audioType, true);
		
		for (group in m_compGroups)
		{
			if(group.audio.audioType == audioType)
				group.audio.mute();
		}
	}
	
	public function unMuteType(audioType : AudioType)
	{
		if (m_allMuted)
			return;
		
		m_muteByType.set(audioType, false);
		
		for (group in m_compGroups)
		{
			if(group.audio.audioType == audioType)
				group.audio.unmute();
		}
	}
	
	public function muteAll() : Void
	{
		if (m_allMuted)
			return;
			
		for (group in m_compGroups)
			group.audio.mute();	
	}
	
	public function unMuteAll() : Void
	{
		if (!m_allMuted)
			return;
			
		for (group in m_compGroups)
		{
			if(!m_muteByType.get(group.audio.audioType))
				group.audio.unmute();
			else
				group.audio.mute(); // juste pour être sur
		}
	}
	
}