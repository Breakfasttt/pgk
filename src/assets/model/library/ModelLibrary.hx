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
	
	//private var m_modelFactory : ModelFactory;
	
	public function new()
	{
		m_modelConfigFilePath = "";
		m_models = new Map();
	}
	
	public function loadModels(modelConfigFilePath : String) : Void
	{
		m_modelConfigFilePath = modelConfigFilePath;
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
	
}