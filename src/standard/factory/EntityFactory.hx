package standard.factory;
import core.entity.Entity;
import standard.components.graphic.Display;
import standard.components.graphic.Representation;
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
	public static function createLayer(layerName : String, depth : Float, w : Float, h : Float) : Entity
	{
		var e : Entity = new Entity(layerName);
		e.add(new Depth(depth));
		e.add(new Pivot2D());
		e.add(new Position2D());
		e.add(new Scale2D());
		e.add(new UtilitySize2D(w, h));
		e.add(new Display(null, true));
		return e;
	}
	
	public static function createGraphicElement(	name : String, parentLayer : String, assetPath : String, 
													x : Float, y : Float, depth : Float, pivot : Anchor, 
													scaleX : Float = 1.0, scaleY : Float = 1.0) : Entity
	{
		var e : Entity = new Entity(name);
		e.add(new Depth(depth));
		e.add(new Pivot2D(pivot));
		e.add(new Position2D(x,y));
		e.add(new Scale2D(scaleX,scaleY));
		e.add(null, UtilitySize2D);
		e.add(new Display(parentLayer, false));
		e.add(new Representation(assetPath));
		return e;
	}
	
}