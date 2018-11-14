package assets.audio;
import openfl.Assets;
import openfl.media.Sound;
import standard.components.audio.Audio;
import standard.components.audio.AudioType;
import tools.file.csv.CsvData;

/**
 * ...
 * @author Breakyt
 */
class AudioLibrary 
{

	private var m_rawAudio : Map<String,Audio>;
	
	public function new() 
	{
		m_rawAudio = new Map<String,Audio>();
	}
	
	public function add(name : String, rawAudio : Audio) : Void
	{
		if (rawAudio == null)
			return;
		
		if (name == null)
			return;
			
		if (m_rawAudio.exists(name))
			trace("WARNING : This raw audio already exist and will be override : " + name);
			
		m_rawAudio.set(name, rawAudio);
	}
	
	public function remove(name : String) : Void
	{
		if (name == null)
			return;
			
		m_rawAudio.remove(name);
	}
	
	public function get(name : String) : Audio
	{
		return m_rawAudio.get(name);
	}
	
	public function loadFromCsv(data : CsvData) : Void
	{
		if (data == null)
			return;
		
		if (!Lambda.has(data.getColumnsName(), "name"))
		{
			trace("can't load audio from " + data.name + " because there are no 'name' column");
			return;
		}
		
		if (!Lambda.has(data.getColumnsName(), "soundpath"))
		{
			trace("can't load audio from " + data.name + " because there are no 'soundpath' column");
			return;
		}
			
		if (!Lambda.has(data.getColumnsName(), "audiotype"))
		{
			trace("can't load audio from " + data.name + " because there are no 'audiotype' column");
			return;
		}	
		
		if (!Lambda.has(data.getColumnsName(), "loop"))
		{
			trace("can't load audio from " + data.name + " because there are no 'audiotype' column");
			return;
		}
		
		if (!Lambda.has(data.getColumnsName(), "volume"))
		{
			trace("can't load audio from " + data.name + " because there are no 'audiotype' column");
			return;
		}
		
		var allRawIds = data.getRawIds();
		var audioName : String = null;
		var audioSound : Sound = null;
		var audioType : AudioType = AudioType.misc;
		var loop : Bool = false;
		var volume : Float = 1.0;
		var newAudio : Audio = null;
		
		for (rawId in allRawIds)
		{
			try
			{
				audioName = data.getCell(rawId, "name");
				audioSound = Assets.getSound(data.getCell(rawId, "soundpath"));
				audioType = Type.createEnum(AudioType, data.getCell(rawId, "audiotype"));
				loop =  Std.parseInt(data.getCell(rawId, "loop")) == 0 ? false : true;
				volume = Std.parseFloat(data.getCell(rawId, "volume"));
				newAudio = new Audio(audioName, audioType, audioSound, loop, volume);
				this.add(audioName, newAudio);
			}
			catch (e : Dynamic)
			{
				trace("Error while creating audio : " + e);
			}
			
		}
		
	}
	
}