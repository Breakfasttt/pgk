package standard.factory;
import assets.model.Model;
import assets.model.library.ModelLibrary;
import assets.model.library.ModelType;
import core.entity.Entity;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.Layer;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.space2d.Depth;
import standard.components.space2d.Pivot2D;
import standard.components.space2d.Position2D;
import standard.components.space2d.Scale2D;
import standard.components.space2d.UtilitySize2D;
import tools.math.Anchor;

/**
 * An helper class to create Prefab Entities
 * @author Breakyt
 */
class EntityFactory 
{

	private var m_modelLibrary : ModelLibrary;
	
	
	public function new(modelLibrary : ModelLibrary)
	{
		m_modelLibrary = modelLibrary;
	}
	
	/**
	 * A layer is a display container where other graphic Element can be added.
	 * @param	layerName
	 * @param	depth
	 * @param	w
	 * @param	h
	 * @return
	 */
	public function createLayer(layerName : String, depth : Float, w : Float, h : Float, position : Anchor = null, pivot : Anchor = null) : Entity
	{
		var e : Entity = new Entity(layerName);
		e.add(new Layer());
		e.add(new Depth(depth));
		e.add(new UtilitySize2D(w, h));
		e.add(new Position2D(position));
		e.add(new Pivot2D(pivot));
		e.add(new Scale2D());
		return e;
	}
	
	public function createGameElement(	name : String, parentLayer : String, modelName : String, 
												depth : Float, position : Anchor, pivot : Anchor, 
												startAnim : String = null, 
												scaleX : Float = 1.0, scaleY : Float = 1.0) : Entity
	{
		var e : Entity = new Entity(name);
		var model : Model = m_modelLibrary.getModel(modelName);
		
		startAnim = startAnim == null ? Model.firstFrameAnim : startAnim;
		
		switch(model.modelData.type)// todo => improve th
		{
			case ModelType.spriteSheet : e.add(new Animation(model, startAnim));
			case ModelType.timeline : e.add(new Animation(model, startAnim));
			default : 
		}
		
		e.add(new GameElementDisplay(parentLayer, model));
		e.add(new Depth(depth));
		e.add(new Position2D(position));
		e.add(new Pivot2D(pivot));
		e.add(new Scale2D(scaleX,scaleY));
		return e;
	}
	
}