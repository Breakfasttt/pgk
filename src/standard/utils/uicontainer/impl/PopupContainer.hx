package standard.utils.uicontainer.impl;

import core.Application;
import core.entity.Entity;
import standard.components.graphic.display.impl.PopUp;
import standard.components.graphic.transition.Opener;
import standard.components.graphic.transition.impl.ScaleTransitionEntity;
import standard.factory.EntityFactory;
import standard.utils.uicontainer.UiContainer;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class PopupContainer extends UiContainer 
{

	private var m_button1 : Entity;
	private var m_button2 : Entity;
	
	public function new(name:String, appRef:Application, entityFactory : EntityFactory) 
	{
		super(name, appRef, entityFactory);
		this.display = new PopUp();
		this.entity.add(this.display);
		this.entity.add(new Opener(new ScaleTransitionEntity(1.0, 1.0, 1.0, false), new ScaleTransitionEntity(1.0, 1.0, 1.0, true)));
		
		createElement();
	}
	
	override private function createElement() : Void
	{
		m_button1 = m_entityFactoryRef.createGameElement("button1", "", "test", 0, Anchor.topLeft, Anchor.topLeft);
		m_button2 = m_entityFactoryRef.createGameElement("button1", "", "test", 0, Anchor.topLeft, Anchor.topLeft);
		this.add(m_button1);
		this.add(m_button2);
	}
	
}