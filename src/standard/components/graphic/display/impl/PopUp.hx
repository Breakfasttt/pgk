package standard.components.graphic.display.impl;

import standard.components.graphic.display.Display;

/**
 * PopUps is a Ui element added on display list with "stack" comportement. (First in First out)
 * Only one popup is showned
 * Its a display without model, you must attach popup's element manually (skin.addhcild) or using gameElement.parentEntity= myPopupEntity
 * It's better to add a fixed Utility Size for entity with popup display.
 * You can extends "PopupContainer" class to create a Popup Entity and Compose it with GameElement Entity
 * @author Breakyt
 */
class PopUp extends Display 
{
	/**
	 * Call by PopupModule just before the popup are added to the display list
	 * and before the open transition
	 * Don't use this callback function to add the popup from display list or from the App
	 * because PopupUpModule already do this
	 */
	public var onInit : Void->Void;
	
	/**
	 * Call by PopupModule when a popup is fully open (after the open transition)
	 * Don't use this callback function to add the popup from display list or from the App
	 * because PopupUpModule already do this
	 */
	public var onOpen : Void->Void;
	
	/**
	 * Call by PopupModule when a popup is fully closed (after the transition animation)
	 * and just before the entity are remove from the App.
	 * Don't use this callback function to remove the popup from display list or from the App
	 * because PopupUpModule already do this
	 * 
	 */
	public var onClose : Void->Void;
	
	public function new() 
	{
		super();
	}
}