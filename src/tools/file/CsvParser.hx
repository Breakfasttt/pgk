package tools.file;

/**
 * ...
 * @author Breakyt
 */
class CsvParser 
{

	private var m_rawdata : String;
	
	private var m_delimiter : String;
	
	private var m_extraColumnsName : String;
	
	public function new(delimiter : String = ";", extraColumnsName : String = "columns_") 
	{
		m_delimiter = delimiter;
		m_extraColumnsName = extraColumnsName;
	}
	
	public function parse(rawData : String, firstLineAsColumnName : Bool = true, customColumnsName : Array<String> = null, columnIdName : String = "id") : CsvData
	{
		m_rawdata = rawData;
		var result = new Array<Map<String,String>>();
		
		if (m_rawdata == null || m_rawdata == "")
			return new CsvData(result,[]);
			
			
		var allLines : Array<String> = m_rawdata.split("\r\n");
		
		if (allLines == null || allLines.length <= 0)
			return new CsvData(result,[]);
			
			
		var lineRawData : String = null;
		var lineData : Array<String> = null;
		var columnsName : Array<String> = null;
		var finalColumnsName : Array<String> = null;
		
		if (firstLineAsColumnName || customColumnsName == null)
		{
			lineRawData = allLines[0];
			columnsName = lineRawData.split(m_delimiter);
		}
		else
			columnsName = customColumnsName;
		
		finalColumnsName = 	columnsName;
			
		var start : Int = 	firstLineAsColumnName ? 1 : 0;
		var maps : Map<String,String> = null;	
		
		for (i in start...allLines.length)
		{
			lineRawData = allLines[i];
			lineData = lineRawData.split(m_delimiter);
			maps = new Map<String,String>();
			
			for (j in 0...columnsName.length)
			{
				if (j >= lineData.length)
					maps.set(columnsName[j], "");
				else
					maps.set(columnsName[j], lineData[j]);
			}
			
			if (lineData.length > columnsName.length)
			{
				for (j in columnsName.length...lineData.length)
				{
					maps.set(m_extraColumnsName + j, lineData[j]);
					finalColumnsName.push(m_extraColumnsName + j);
				}
			}
			
			result.push(maps);
		}
		
		for (map in result)
		{
			for (column in finalColumnsName)
			{
				if (!map.exists(column))
					map.set(column, "");
			}
		}
		
		return new CsvData(result, finalColumnsName, columnIdName) ;
	}
	
}