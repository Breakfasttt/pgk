package standard.components.input;
import core.entity.Entity;
import input.behaviour.impl.DragBehaviour;
import standard.components.graphic.display.Display;
import standard.components.space2d.Position2D;
import tools.math.Vector2D;

/**
 * A Pointer Behaviour component to drag'n'drop an entity
 * @author Breakyt
 */
class DragComponent extends PointerBehaviourComponent 
{

	private var m_displayRef : Display;
	private var m_position2DRef : Position2D;
	
	public function new() 
	{
		super();
		
	}
	
	override public function setEntityRef(entityRef:Entity):Void 
	{
		super.setEntityRef(entityRef);
		
		if (m_entityRef == null)
			return;
			
		m_displayRef = m_entityRef.getComponent(Display);
		m_position2DRef = m_entityRef.getComponent(Position2D);
		
		if (m_displayRef == null || m_position2DRef == null)
			return;
			
		m_position2DRef.position2d.ratioMode = false;
			
		m_pointerBehaviour = new DragBehaviour(m_displayRef.skin);
		
		cast(m_pointerBehaviour, DragBehaviour).moveCb = onEntityMove;
	}
	
	private function onEntityMove(pos : Vector2D) : Void
	{
		m_position2DRef.position2d.anchor.set(pos);
	}
	
	override public function delete():Void 
	{
		super.delete();
		
		m_displayRef = null;
		m_position2DRef = null;
	}
	
}