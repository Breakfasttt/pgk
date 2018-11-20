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
	
	private var m_localizationFiles : Array<CsvData>;
	
	/**
	 * @param	localizationFile : A csv file who contains a column with 'id' and many columns with 'localeCode'
	 * @param	localeCode : The current localCode To use
	 */
	public function new(localeCode : String) 
	{
		super(LocalizationGroup);
		m_localizationFiles = new Array();
		this.localeCode = localeCode;
	}
	
	public function addLocalizationFile(csv : CsvData) : Void
	{
		if (csv.getColumnsName().indexOf('id') == -1)
		{
			trace("can't add an invalid localization files (missing id columns)");
			return;
		}
		
		m_localizationFiles.push(csv);
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
		var newText : String = null;
		for (file in m_localizationFiles)
		{
			newText = file.getCell(group.localization.m_keyword, localeCode);
			if (newText == null)
			{
				trace(" /!\\ Warning /!\\ : Missing keyword :  [" + group.localization.m_keyword + "] on file [" + file.name + "] or missing localeCode [" + this.localeCode + "]");
				continue;
			}
			//https://github.com/polygonal/printf
			if(group.localization.m_textDatas != null)
				newText = Printf.format(newText, group.localization.m_textDatas);
				
			break;
		}
		
		if (newText == null)
			newText = "/!\\ missingLocaleKey /!\\";
		group.textDisplay.text.text = newText;
	}
	
	
	public function setLocaleCode(localeCode : String) : Void
	{
		this.localeCode = localeCode;
		for (group in m_compGroups)
			updateTextDisplay(null, group);
	}
	
	public function getLocaleCodes() : Array<String>
	{
		var result = [];
		for (file in m_localizationFiles)
		{
			for (column in file.getColumnsName())
			{
				if (result.indexOf(column) == -1)
					result.push(column);
			}	
		}
		
		result.remove("id");
		return result;
	}
}