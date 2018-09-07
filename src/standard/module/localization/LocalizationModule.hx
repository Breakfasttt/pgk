package standard.module.localization;

import core.module.Module;
import de.polygonal.Printf;
import standard.components.localization.Localization;
import standard.group.localization.LocalizationGroup;
import tools.file.csv.CsvData;

/**
 * ...
 * @author Breakyt
 */
class LocalizationModule extends Module<LocalizationGroup>
{

	public var localeCode(default,null) : String;
	
	private var m_localizationFile : CsvData;
	
	/**
	 * @param	localizationFile : A csv file who contains a column with 'id' and many columns with 'localeCode'
	 * @param	localeCode : The current localCode To use
	 */
	public function new(localizationFile : CsvData, localeCode : String) 
	{
		super(LocalizationGroup);
		m_localizationFile = localizationFile;
		this.localeCode = localeCode;
	}
	
	override function onCompGroupAdded(group:LocalizationGroup):Void 
	{
		group.localization.stateChanged.add(updateTextDisplay.bind(_, group));
		this.updateTextDisplay(group.localization, group);
	}
	
	override function onCompGroupRemove(group:LocalizationGroup):Void 
	{
		group.localization.stateChanged.removeAll();
	}
	
	
	override public function update(delta:Float):Void 
	{
		
	}
	
	private function updateTextDisplay(notUsed : Localization, group : LocalizationGroup) : Void
	{
		var newText : String = m_localizationFile.getCell(group.localization.m_keyword, localeCode);
		//https://github.com/polygonal/printf
		
		if(group.localization.m_textDatas != null)
			newText = Printf.format(newText, group.localization.m_textDatas);
			
		group.textDisplay.text.text = newText;
	}
	
	public function setLocaleCode(localeCode : String) : Void
	{
		if (m_localizationFile.getColumnsName().indexOf(localeCode) != -1)
		{
			this.localeCode = localeCode;
			
			for (group in m_compGroups)
				updateTextDisplay(null, group);
			
		}
	}
	
	public function getLocaleCodes() : Array<String>
	{
		var result = m_localizationFile.getColumnsName();
		result.remove("id");
		return result;
	}
}