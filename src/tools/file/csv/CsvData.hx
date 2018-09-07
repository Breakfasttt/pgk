package tools.file.csv;

/**
 * ...
 * @author Breakyt
 */
class CsvData
{

	private var m_idsIndex : Map<String,Int>;
	
	private var m_rawIds : Array<String>;
	
	private var m_columns : Array<String>;
	
	private var m_datas : Array<Map<String,String>>;
	
	@:allow(tools.file.csv.CsvParser)
	private function new(datas : Array<Map<String,String>>, columns : Array<String>, columnIdName : String = "id") 
	{
		m_datas = datas;
		m_columns = columns;
		m_rawIds = new Array();
		m_idsIndex = new Map();
		
		var lineData : Map<String,String> = null;
		var id : String = "";
		
		for (i in 0...m_datas.length)
		{
			lineData = m_datas[i];
			if (Lambda.has(m_columns, columnIdName))
				id = lineData.get(columnIdName);
			else
				id = "" + i;
			
			m_rawIds.push(id);
			m_idsIndex.set(id, i);
		}
	}
	
	/**
	 * Get a raw by is Id. The id is set on parsing. 
	 * Id the csv doesn't contain an 'id' column, the id is the number of the raw.
	 * @param	id
	 * @return a Map of "Column=>data" or null if data not found or Id is wrong/unknow,  
	 */
	public function getRaw(id : String) : Map<String,String>
	{
		if (m_datas.length <= 0)
			return null;
			
		if (m_idsIndex.get(id) == null)
			return null;
		
		return m_datas[m_idsIndex.get(id)];
	}
	
	/**
	 * Get the data at raw/column by the raw id and the column name
	 * @param	id
	 * @param	column
	 * @return the Data String or null if data not found or Id/ColumnName is wrong/unknow,  
	 */
	public function getCell(id : String, column : String) : String
	{
		if (m_datas.length <= 0)
			return null;
			
		var raw = getRaw(id);
		if (raw == null)
			return  null;
			
		return raw.get(column);
	}
	
	/**
	 * Get a raw by his index on the file.
	 * @param	index
	 * @return a map of Column=>Data String or null if data not found or Indexes is wrong/unknow,  
	 */
	public function getRawByIndex(index : Int) : Map<String,String>
	{
		if (m_datas.length <= 0 || index < 0 || index >= m_datas.length)
			return null;
		
		return m_datas[index];
	}
	
	/**
	 * Get the data at raw/column by the raw index and the columnName
	 * @param	index
	 * @param	column
	 * @return the Data String or null if data not found or Indexes is wrong/unknow,  
	 */
	public function getCellByRawIndex(index : Int, column : String) : String
	{
		if (m_datas.length <= 0 || index < 0 || index >= m_datas.length)
			return null;
			
		var raw = getRawByIndex(index);
		if (raw == null)
			return null;	
			
		return raw.get(column);
	}
	
	/**
	 * Get the data at raw/column by the raw index and the column Index
	 * @param	index
	 * @param	column
	 * @return the Data String or null if data not found or Indexes is wrong/unknow,  
	 */
	public function getCellByIndexes(index : Int, columnIndex : Int) : String
	{
		if (m_datas.length <= 0 || index < 0 || index >= m_datas.length)
			return null;
			
		if (columnIndex <= 0 || columnIndex < 0 || columnIndex >= m_columns.length)
			return null;
			
		var raw = getRawByIndex(index);
		if (raw == null)
			return null;	
			
		return raw.get(m_columns[columnIndex]);
	}
	
	
	/**
	 * See all data (usefull for debug)
	 * @return
	 */
	public function toString() : String
	{
		var result : String = "";
		
		for (line in m_datas)
		{
			result += "[ \n";
			for (columns in m_columns)
				result +=  "\t" + columns + ":" + line.get(columns) + "\n";
			result += "] \n";
		}
		return result;
	}
	
	/**
	 * @return all raw ids
	 */
	public function getRawIds() : Array<String>
	{
		return m_rawIds.concat([]);
	}
	
	/**
	 * @return all columns name
	 */
	public function getColumnsName() : Array<String>
	{
		return m_columns.concat([]);
	}
	
	
}