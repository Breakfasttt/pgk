package standard.components.localization;

import core.component.Component;
import msignal.Signal.Signal1;

/**
 * A component who have a keyword represents an id to get a sentence 
 * saved into a localization csv file
 * Extra data can be inject into the sentence with %s %d etc..
 * Data must be already sorted.
 * 
 * exemple : keyword get this sentence from a localization csv file :
 * "hello %s, i see you are a %s" and textData = [warrior, champion]
 * 
 * LocalizationSystem deal with it to change the sentence by : 
 * hello warrior, i see you are a champion
 * 
 * @author Breakyt
 */
class Localization extends Component 
{

	/**
	 * A signal dispatch when 'keyword' or 'm_textDatas' change
	 */
	public var stateChanged(default,null) : Signal1<Localization>;
	
	/**
	 * The keyword/id who point to an line of csv file
	 */
	@:allow(standard.module.localization.LocalizationModule)
	private var m_keyword : String;
	
	/**
	 * The data needed to be injected into the sentence
	 */
	@:allow(standard.module.localization.LocalizationModule)
	private var m_textDatas : Array<Dynamic>;
	
	/**
	 * @param	keyw 
	 * @param	textDatas
	 */
	public function new(keyw : String, textDatas : Array<Dynamic> = null) 
	{
		super();
		m_keyword = keyw;
		m_textDatas = textDatas;
		this.stateChanged = new Signal1<Localization>();
	}
	
	public function setKeyword(keyw:String):Void 
	{
		m_keyword = keyw;
		this.stateChanged.dispatch(this);
	}
	
	/**
	 * 
	 * @param	keyw
	 * @param	textDatas
	 */
	public function set(keyw : String, textDatas : Array<Dynamic> = null) : Void
	{
		m_keyword = keyw;
		m_textDatas = textDatas;
		this.stateChanged.dispatch(this);
	}
	
	/**
	 * Set the injected datas. Dispatch 'stateChanged'
	 */
	public function setDatas(textDatas : Array<Dynamic> = null) : Void
	{
		m_textDatas = textDatas;
		this.stateChanged.dispatch(this);
	}
	
	/**
	 * Set  the injected data at 'index' by 'data'
	 * Dispatch 'stateChanged' signal
	 * @param	index
	 * @param	data
	 */
	public function setDataAt(index : Int, data : Dynamic) : Void
	{
		if (m_textDatas == null)
			return;
			
		if (index < 0 || index > m_textDatas.length)
			return;
				
		m_textDatas[index] = data;
		this.stateChanged.dispatch(this);
	}
	
	/**
	 * Return the injected data at 'index'
	 * If not found or textData does't exist, return null
	 * @param	index
	 * @return
	 */
	public function getDataAt(index : Int) : Dynamic
	{
		if (m_textDatas == null)
			return null;
			
		if (index < 0 || index > m_textDatas.length)
			return null;
			
		return m_textDatas[index];
	}
	
	/**
	 * add a new data to the textData. id textData doesn't exist, an array is created
	 * dispatch stateChanged
	 * @param	data
	 */
	public function addData(data : Dynamic) : Void
	{
		if (m_textDatas == null)
			m_textDatas = new Array();
			
		m_textDatas.push(data);
		this.stateChanged.dispatch(this);
	}
	
	/**
	 * remove a data (if exist) from the textData
	 * dispatch stateChanged
	 * @param	data
	 */
	public function removeData(data : Dynamic) : Void
	{
		if (m_textDatas == null)
			return;
			
		if (m_textDatas.remove(data))
			this.stateChanged.dispatch(this);
	}
	
	
	
}