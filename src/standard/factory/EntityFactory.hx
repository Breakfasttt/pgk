package standard.factory;
import assets.audio.AudioLibrary;
import assets.model.Model;
import assets.model.library.ModelLibrary;
import assets.model.library.ModelType;
import core.entity.Entity;
import standard.components.audio.Audio;
import standard.components.graphic.animation.Animation;
import standard.components.graphic.display.impl.Layer;
import standard.components.graphic.display.Display;
import standard.components.graphic.display.impl.GameElementDisplay;
import standard.components.graphic.display.impl.TextDisplay;
import standard.components.input.PointerBehavioursComponent;
import standard.components.input.utils.EntityAsSimpleButton;
import standard.components.localization.Localization;
import standard.components.misc.ParentEntity;
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
	
	private var m_audioLibrary : AudioLibrary;
	
	public function new(modelLibrary : ModelLibrary, audioLibraryRef : AudioLibrary)
	{
		m_modelLibrary = modelLibrary;
		m_audioLibrary = audioLibraryRef;
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
	
	public function createGameElement(	name : String, parentEntity : Entity, modelName : String, 
												depth : Float, position : Anchor, pivot : Anchor, 
												startAnim : String = null, 
												scaleX : Float = 1.0, scaleY : Float = 1.0) : Entity
	{
		var e : Entity = new Entity(name);
		var model : Model = m_modelLibrary.getModel(modelName);
		
		startAnim = startAnim == null ? Model.firstFrameAnim : startAnim;
		
		if (model != null)
		{
			switch(model.modelData.type)// todo => improve th
			{
				case ModelType.spriteSheet : e.add(new Animation(model, startAnim));
				case ModelType.flashSpriteSheet : e.add(new Animation(model, startAnim));
				case ModelType.timeline : e.add(new Animation(model, startAnim));
				default : 
			}
			
			e.add(new UtilitySize2D(model.getMaxWidth(), model.getMaxHeight()));
		}
			
		
		e.add(new GameElementDisplay(model));
		e.add(new Depth(depth));
		e.add(new Position2D(position));
		e.add(new Pivot2D(pivot));
		e.add(new Scale2D(scaleX, scaleY));
		
		if (parentEntity != null)
			e.add(new ParentEntity(parentEntity));
		
		return e;
	}
	
	/**
	 * Use this function only if you need a new specific SimpleBtn.
	 * Prefer new Button() or new TextButton() or new LocTextButton()
	 * @param	name
	 * @param	parentEntity
	 * @param	modelName
	 * @param	depth
	 * @param	position
	 * @param	pivot
	 * @param	onSelect
	 * @param	onUnSelect
	 * @param	onRollOver
	 * @param	onRollOut
	 * @param	scaleX
	 * @param	scaleY
	 * @return
	 */
	public function createSimpleBtn(name : String, parentEntity : Entity, modelName : String, depth : Float, 
										position : Anchor, pivot : Anchor, 
										onSelect : Void->Void = null,
										onUnSelect : Void->Void  = null,
										onRollOver : Void->Void  = null,
										onRollOut : Void->Void  = null,
										scaleX : Float = 1.0, scaleY : Float = 1.0) : Entity
	{
		var entity = this.createGameElement(name, parentEntity, modelName, depth, position, pivot, null, scaleX, scaleY);
		var behaviours : PointerBehavioursComponent = new PointerBehavioursComponent();
		var btnBehaviour : EntityAsSimpleButton = new EntityAsSimpleButton(false);
		btnBehaviour.onSelect = onSelect;
		btnBehaviour.onUnSelect = onUnSelect;
		btnBehaviour.onRollOver = onRollOver;
		btnBehaviour.onRollOut =  onRollOut;
		
		behaviours.addBehaviour(btnBehaviour, 0);
		entity.add(behaviours);
		
		try
		{
			entity.getComponent(Animation).useAnimationPivot = false;
		}
		catch (e : Dynamic)
		{
			//nothing special
		}
		
		return entity;
	}
	
	
	public function createTextField(	name : String, parentEntity : Entity, text : String, 
												depth : Float, position : Anchor, pivot : Anchor, 
												startAnim : String = null, 
												scaleX : Float = 1.0, scaleY : Float = 1.0) : Entity
	{
		
		var e : Entity = new Entity(name);
		
		e.add(new TextDisplay(text));
		e.add(new Depth(depth));
		e.add(new Position2D(position));
		e.add(new Pivot2D(pivot));
		e.add(new Scale2D(scaleX, scaleY));
		
		if (parentEntity != null)
			e.add(new ParentEntity(parentEntity));
		
		return e;
	}
	
	public function createLocTextField(	name : String, parentEntity : Entity,
												keyword : String, textData : Array<Dynamic>,
												depth : Float, position : Anchor, pivot : Anchor, 
												startAnim : String = null, 
												scaleX : Float = 1.0, scaleY : Float = 1.0) : Entity
	{
		
		var e : Entity = new Entity(name);
		
		e.add(new TextDisplay(keyword));
		e.add(new Depth(depth));
		e.add(new Position2D(position));
		e.add(new Pivot2D(pivot));
		e.add(new Scale2D(scaleX, scaleY));
		e.add(new Localization(keyword, textData));
		
		if (parentEntity != null)
			e.add(new ParentEntity(parentEntity));
		
		return e;
	}
	
	public function createAudioEntity(audioName : String) : Entity
	{
		var audio = m_audioLibrary.get(audioName);
		
		if (audio == null)
		{
			trace("Can't create this entity : " + audioName + " with an unknow Audio component");
			return null;
		}
		
		var e : Entity = new Entity(audioName);
		e.add(audio);
		return e;
	}
	
	
	
	
	
}