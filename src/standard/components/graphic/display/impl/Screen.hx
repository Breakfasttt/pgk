package standard.components.graphic.display.impl;

import core.component.Component;
import standard.components.graphic.display.Display;

/**
 * A Screen is a Uielement always "open". A screen is show or hide and keep his state along the soft.
 * Its a display without model, you must attach screen's element manually (skin.addhcild) or using gameElement.parentEntity = myScreenEntity
 * It's better to add a fixed Utility Size for entity with screen display.
 * You can extends "ScreenContainer" class to create a Screen Entity and Compose it with GameElement Entity.
 * @author Breakyt
 */
class Screen extends Display 
{
	
	public var onInit : Void->Void;
	
	public var onOpen : Void->Void;
	
	public var onClose : Void->Void;
	
	public function new() 
	{
		super();	
	}
	
}