package standard.utils.uicontainer;
import core.Application;
import core.entity.Entity;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.misc.ParentEntity;
import standard.components.space2d.Pivot2D;
import standard.components.space2d.Position2D;
import standard.components.space2d.Rotation2D;
import standard.components.space2d.Scale2D;
import standard.components.space2d.UtilitySize2D;
import standard.factory.EntityFactory;
import tools.math.Anchor;

/**
 * ...
 * @author Breakyt
 */
class UiContainer 
{

	private var m_appRef : Application;
	private var m_entityFactoryRef : EntityFactory;
	
	public var entity(default, null) : Entity;
	
	public var position(default, null) : Position2D;
	public var pivot(default,null) : Pivot2D;
	public var scale(default,null) : Scale2D;
	public var utilitySize(default,null) : UtilitySize2D;
	public var rotation(default,null) : Rotation2D;
	public var display(default,null) : Display;
	
	
	public function new(name : String, appRef : Application, entityFactory : EntityFactory) 
	{
		m_appRef = appRef;
		m_entityFactoryRef = entityFactory;
		this.entity = new Entity(name);
		
		this.position = new Position2D(Anchor.topLeft);
		this.pivot = new Pivot2D(Anchor.topLeft);
		this.scale = new Scale2D();
		this.utilitySize = new UtilitySize2D(0, 0, true);
		this.rotation = new Rotation2D();
		
		this.entity.add(this.position);
		this.entity.add(this.pivot);
		this.entity.add(this.scale);
		this.entity.add(this.utilitySize);
		this.entity.add(this.rotation);
	}
	
	public function add(e : Entity) : Void
	{
		var parentComp :  ParentEntity = e.getComponent(ParentEntity);
		
		if (parentComp != null)
			parentComp.setParent(this.entity);
		else
		{
			parentComp = new ParentEntity(this.entity);
			e.add(parentComp);
		}
			
		if (m_appRef != null)
			m_appRef.addEntity(e);
	}
	
	public function remove(e : Entity) : Void
	{
		var parentComp :  ParentEntity = e.getComponent(ParentEntity);
		if (parentComp != null)
			parentComp.setParent(null);
		
		if (m_appRef != null)
			m_appRef.removeEntity(e);
	}
	
	/**
	 * Override it to add element with add() function to compose the container
	 */
	private function createElement() : Void
	{
		trace("UiContainer::createElement:: override it");
	}
	
}