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
	public var pointerId(default, null) : Int;
	
	public var target(default,null) : InteractiveObject;
	
	public var localPosition(default,null) : Vector2D;
	
	public var worldPosition(default,null) : Vector2D;
	
	public var deltaScroll(default,null) : Float;
	
	public var altModifier(default,null) : Bool;
	
	public var ctrlModifier(default, null) : Bool;
	
	
	
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
		this.pointerId = 0;
		this.target = event.target;
		this.altModifier = event.altKey;
		this.ctrlModifier = event.ctrlKey;
		this.deltaScroll = event.delta;
		this.localPosition.set(event.localX, event.localY);
		this.worldPosition.set(event.stageX, event.stageY);
	}
	
	private function retrieveTouchData(event : TouchEvent) : Void
	{
		this.pointerId = event.touchPointID;
		this.target = event.target;
		this.altModifier = event.altKey;
		this.ctrlModifier = event.ctrlKey;
		this.deltaScroll = event.delta;
		this.localPosition.set(event.localX, event.localY);
		this.worldPosition.set(event.stageX, event.stageY);
	}	
	
	public function toString() : String
	{
		return "PointerId : " + pointerId + " target : " + target + " localPosition :"  + localPosition + " worldPosition : " + worldPosition + " deltaScroll : " + deltaScroll  + " altModifier : " + altModifier + " ctrlModifier :" + ctrlModifier; 
	}
}