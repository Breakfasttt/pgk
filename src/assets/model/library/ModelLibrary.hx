package assets.model.library;
import assets.model.Model;

/**
 * ...
 * @author Breakyt
 */
class ModelLibrary 
{

	
	private var m_models : Map<String, Model>;
	
	private var m_modelConfigFilePath : String;
	
	private var m_modelFactory : ModelFactory;
	
	private var m_modelLoader : ModelDataLoader;
	
	public function new(factory : ModelFactory)
	{
		m_modelConfigFilePath = "";
		m_models = new Map();
		m_modelFactory = factory;
	}
	
	
	public function hasModel(modelName : String) : Bool 
	{
		return m_models.exists(modelName);
	}
	
	public function getModel(modelName : String) : Model
	{
		return m_models.get(modelName);
	}
	
	public function addModel(modelName : String, model : Model, eraseOld : Bool = false)
	{
		if (model == null)
			return;
		
		var oldModel : Model = m_models.get(modelName);
		
		if (oldModel !=null && !eraseOld)
		{
			trace("this model : " + modelName + " already exist. Use eraseOld = true to delete and replace this model");
			return;
		}
		else if (oldModel != null && eraseOld)
		{
			model.delete();
			model = null;
		}
		
		m_models.set(modelName, model);
	}
	
	public function removeModel(modelName : String) : Void
	{
		var model : Model = m_models.get(modelName);
		
		if (model != null)
			model.delete();
			
		m_models.remove(modelName);
	}
	
	public function loadModels(modelDescriptorFile : String) : Void
	{
		if (m_modelFactory == null)
		{
			trace("WARNING :: Can't load models because factory is null - ABORTED");
			return;
		}
		
		var modelDataLoader : ModelDataLoader = new ModelDataLoader(modelDescriptorFile);
		var modelsData : Array<ModelData> = modelDataLoader.loadModelData();		
		
		for (data in modelsData)
			this.addModel(data.name, m_modelFactory.createModel(data));
	}
	
}