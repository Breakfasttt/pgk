package tools.file.csv;
import tools.file.csv.CsvData;

/**
 * A csv file parser.
 * This parser Doesn't manage quoted data. So if you have datas with delimiter symbol on it, 
 * this will  make 2 columns instead of check data with delimiter symbol
 * @author Breakyt
 */
class CsvParser 
{

	private var m_rawdata : String;
	
	private var m_delimiter : String;
	
	private var m_extraColumnsName : String;
	
	/**
	 * This parser doesn't manage quoted data. So if you have datas with delimiter symbol on it, 
	 * this will  make 2 columns instead of check data with delimiter symbol.
	 * 
	 * @param	delimiter : the delimiter used on the file
	 * @param	extraColumnsName :  If a raw have more 'data columns' that the 'raw columns names', 
	 * so extra columns are added with 'extraColumnsName' + column_number
	 */
	public function new(delimiter : String = ";", extraColumnsName : String = "columns_") 
	{
		m_delimiter = delimiter;
		m_extraColumnsName = extraColumnsName;
	}
	
	/**
	 * 
	 * @param	rawData : the raw data text file to parse
	 * @param	firstLineAsColumnName : set if you want  the first raw considerate as column name . If not, customColumnsName is used
	 * @param	customColumnsName : Set your own columns titles. (only works if firstLineAsColumnName = false)
	 * @param	columnIdName : set the column name to register the string "id" of lines
	 * @return CsvData object who is a double entry array  with "id" for raw and "columnName" for column. 
	 * 
	 * Note : If a raw have more 'data columns' that the 'raw columns names' extra columns are added with 'extraColumnsName' + column_number
	 */
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
		
		if (firstLineAsColumnName)
		{
			lineRawData = allLines[0];
			columnsName = lineRawData.split(m_delimiter);
		}
		else if(customColumnsName != null)
			columnsName = customColumnsName;
		else
			columnsName = [];
		
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