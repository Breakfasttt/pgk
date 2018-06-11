package standard.module.debug;
import core.entity.Entity;
import core.module.Module;
import openfl.Lib;
import openfl.text.TextField;
import standard.components.graphic.display.impl.Layer;
import standard.factory.EntityFactory;
import standard.group.debug.DebugGroup;

/**
 * 
 * @author Breakyt
 */
class DebugModule extends Module<DebugGroup>
{

	private var m_layerEntityRef : Entity;
	
	private var m_entityFactoryRef : EntityFactory;
	
	private var m_enable : Bool;
	
	public function new(layerEntityRef : Entity, entityFactoryRef : EntityFactory) 
	{
		super(DebugGroup);
		m_layerEntityRef = layerEntityRef;
		m_entityFactoryRef = entityFactoryRef;
		m_enable = true;
	}
	
	override function onAddedToApplication():Void 
	{
		
	}	
	
	override function onRemoveFromApplication():Void 
	{
		
	}
	
	override function onCompGroupAdded(group:DebugGroup):Void 
	{
		super.onCompGroupAdded(group);
		
		if(m_enable)
			group.debugComp.initWhenAdded(this.m_appRef, this.m_layerEntityRef, this.m_entityFactoryRef);
	}
	
	override function onCompGroupRemove(group:DebugGroup):Void 
	{
		super.onCompGroupRemove(group);
		group.debugComp.deleteWhenRemove(this.m_appRef, this.m_layerEntityRef, this.m_entityFactoryRef);
	}
	
	override public function update(delta:Float):Void 
	{
		if (!m_enable)
			return;
		
		for (group in m_compGroups)
			group.debugComp.update(delta);
	}
	
	public function enable(enable : Bool) : Void 
	{
		if (m_enable != enable)
		{
			m_enable = enable;
			
			for (group in m_compGroups)
			{
			if (m_enable)
				group.debugComp.initWhenAdded(this.m_appRef, this.m_layerEntityRef, this.m_entityFactoryRef);
			else
				group.debugComp.deleteWhenRemove(this.m_appRef, this.m_layerEntityRef, this.m_entityFactoryRef);
			}
		}
	}
}