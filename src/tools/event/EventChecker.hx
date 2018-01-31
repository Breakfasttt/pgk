package tools.event;
import openfl.display.InteractiveObject;

/**
 * A simple class to be sure that all function bind with an flash type event are correctly add/remove from an Interactive object
 * usefull when tou add an event with a function who bind data (addEventListener(Event.event, myFunct.bind(data))).
 * Because you can't remove it without a reference on this function => myFunct.bind(data). (the function has another memory adress than the original)
 * This class keep a reference of all function to be sure to remove it when removeEventListener is call
 * @author Breakyt
 */
class EventChecker 
{

	/**
	 * The object reference
	 */
	private var m_objRef : InteractiveObject;
	
	/**
	 * The map of binded function
	 * @param	objRef
	 */
	private var m_bindedFunction : Map<String, Array<Dynamic>>;
	
	public function new(objRef : InteractiveObject) 
	{
		m_objRef = objRef;
		m_bindedFunction = new Map<String, Array<Dynamic>>();
	}
	
	/**
	 * add an event to the objRef
	 * @param	eventName : the event (like MouseEvent.MOVE)
	 * @param	funct : the function to add
	 * @return
	 */
	public function addEvent(eventName : String, funct : Dynamic) : Bool
	{
		if (m_objRef == null)
			return false;
		
		var m_toolsArray : Array<Dynamic> = null;
		
		if (m_bindedFunction.exists(eventName))
			m_toolsArray = m_bindedFunction.get(eventName);
		else
			m_toolsArray = new Array<Dynamic>();
			
		if (Lambda.has(m_toolsArray, funct))
			return false;
					
		m_objRef.addEventListener(eventName, funct);
		m_toolsArray.push(funct);
		m_bindedFunction.set(eventName, m_toolsArray);
		return true;
	}
	
	/**
	 * Remove an event from the interactive obj
	 * @param	eventName : event to remove
	 * @param	functRef : Remove a specific function bind with the specified event. If null, remove all function bind with the specified event.
	 * @return
	 */
	public function removeEvent(eventName : String, functRef : Dynamic = null) : Bool
	{
		if (m_objRef == null)
			return false;
		
		if (!m_bindedFunction.exists(eventName))
			return false;
		
		var m_toolsArray : Array<Dynamic> = m_bindedFunction.get(eventName);
		var specificFunctionRemove : Bool = false;
		
		for (funcToRemove in m_toolsArray)
		{
			if (functRef == null)
				m_objRef.removeEventListener(eventName, funcToRemove);
			else if (functRef == funcToRemove)
			{
				specificFunctionRemove = true;
				m_objRef.removeEventListener(eventName, funcToRemove);
			}
		}
		
		if (functRef == null)
			m_bindedFunction.remove(eventName);
		else if(specificFunctionRemove)
		{
			m_toolsArray.remove(functRef);
			m_bindedFunction.set(eventName, m_toolsArray);
		}
			
		return true;
	}
	
	
}