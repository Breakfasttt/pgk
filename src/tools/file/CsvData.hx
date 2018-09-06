package tools.file;

/**
 * ...
 * @author Breakyt
 */
class CsvData
{

	private var m_idsIndex : Map<String,Int>;
	
	private var m_lineIds : Array<String>;
	
	private var m_columns : Array<String>;
	
	private var m_datas : Array<Map<String,String>>;
	
	@:allow(tools.file.CsvParser)
	private function new(datas : Array<Map<String,String>>, columns : Array<String>, columnIdName : String = "id") 
	{
		m_datas = datas;
		m_columns = columns;
		m_lineIds = new Array();
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
			
			m_lineIds.push(id);
			m_idsIndex.set(id, i);
		}
	}
	
	
	public function getLine(id : String) : Map<String,String>
	{
		if (m_datas.length <= 0)
			return null;
		
		return m_datas[m_idsIndex.get(id)];
	}
	
	public function getCell(id : String, column : String) : String
	{
		if (m_datas.length <= 0)
			return null;
			
		return getLine(id).get(column);
	}
	
	public function getLineByIndex(index : Int) : Map<String,String>
	{
		if (m_datas.length <= 0 || index < 0 || index >= m_datas.length)
			return null;
		
		return m_datas[index];
	}
	
	public function getCellByIndex(index : Int, column : String) : String
	{
		if (m_datas.length <= 0 || index < 0 || index >= m_datas.length)
			return null;
			
		return getLineByIndex(index).get(column);
	}
	
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
	
	
}