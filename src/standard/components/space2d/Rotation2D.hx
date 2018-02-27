package standard.components.space2d;
import core.component.Component;
import tools.math.MathUtils;

/**
 * ...
 * @author Breakyt
 */
class Rotation2D extends Component
{

	/**
	 * angle in degree
	 */
	public var angle(default, set) : Float;
	
	/**
	 * angle in radian
	 */
	public var radAngle(default,null) : Float;
	
	public function new(angle : Float = 0.0) 
	{
		super();
		this.angle = angle;
		this.radAngle = MathUtils.toRad(this.angle);
	}
	
	function set_angle(value:Float):Float 
	{
		angle = value;
		
		//todo
		if (angle > 360.0)
			angle = angle % 360.0;
		
		radAngle = MathUtils.toRad(angle);
		return angle;
	}
	
}