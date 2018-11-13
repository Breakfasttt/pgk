package standard.group.audio;

import core.component.Component;
import core.component.ComponentGroup;
import standard.components.audio.Audio;

/**
 * ...
 * @author Breakyt
 */
class AudioGroup extends ComponentGroup
{

	public var audio : Audio;
	
	public function new() 
	{
		super();
		this.bindFieldType(Audio, "audio"); 	
	}
	
	
	
}