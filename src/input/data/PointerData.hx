package input.data;
import input.pointerImpl.BasicMouseSignals;
import openfl.display.InteractiveObject;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import tools.math.Vector2D;

/**
 * ...
 * @author Breakyt
 */
class PointerData 
{
	@:allow(input.pointerImpl.BasicMouseSignals)
	public var target(default,null) : InteractiveObject;
	
	@:allow(input.pointerImpl.BasicMouseSignals)
	public var localPosition(default,null) : Vector2D;
	
	@:allow(input.pointerImpl.BasicMouseSignals)
	public var worldPosition(default,null) : Vector2D;
	
	@:allow(input.pointerImpl.BasicMouseSignals)
	public var deltaScroll(default,null) : Float;
	
	@:allow(input.pointerImpl.BasicMouseSignals)
	public var altModifier(default,null) : Bool;
	
	@:allow(input.pointerImpl.BasicMouseSignals)
	public var ctrlModifier(default,null) : Bool;
	
	public function new() 
	{
		localPosition = new Vector2D();
		worldPosition = new Vector2D();
	}
	
	
	public function retrieveEventData(event : Event) : Void
	{
		switch(Type.getClass(event))
		{
			case MouseEvent : 
			{
				retrieveMouseData(cast event);
			}
			case TouchEvent : 
			{
				retrieveTouchData(cast event);
			}
			default : 
			{
				return;
			}
		}
	}
	
	
	private function retrieveMouseData(event : MouseEvent) : Void
	{
		this.target = event.target;
		this.altModifier = event.altKey;
		this.ctrlModifier = event.ctrlKey;
		this.deltaScroll = event.delta;
		this.localPosition.set(event.localX, event.localY);
		this.worldPosition.set(event.stageX, event.stageY);
	}
	
	private function retrieveTouchData(event : TouchEvent) : Void
	{
		this.target = event.target;
		this.altModifier = event.altKey;
		this.ctrlModifier = event.ctrlKey;
		this.deltaScroll = event.delta;
		this.localPosition.set(event.localX, event.localY);
		this.worldPosition.set(event.stageX, event.stageY);
	}	
	
	public function toString() : String
	{
		return "target : " + target + " localPosition :"  + localPosition + " worldPosition : " + worldPosition + " deltaScroll : " + deltaScroll  + " altModifier : " + altModifier + " ctrlModifier :" + ctrlModifier; 
	}
}