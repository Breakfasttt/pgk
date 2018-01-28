package standard.factory;
import core.entity.Entity;
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

	/**
	 * A layer is a display container where other graphic Element can be added.
	 * @param	layerName
	 * @param	depth
	 * @param	w
	 * @param	h
	 * @return
	 */
	public static function createLayer(layerName : String, depth : Float, w : Float, h : Float, position : Anchor = null, pivot : Anchor = null) : Entity
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
	
	public static function createGameElement(	name : String, parentLayer : String, assetPath : String, 
												depth : Float, position : Anchor, pivot : Anchor, 
												scaleX : Float = 1.0, scaleY : Float = 1.0) : Entity
	{
		var e : Entity = new Entity(name);
		e.add(new GameElementDisplay(parentLayer, assetPath));
		e.add(new Depth(depth));
		e.add(new Position2D(position));
		e.add(new Pivot2D(pivot));
		e.add(new Scale2D(scaleX,scaleY));
		return e;
	}
	
}