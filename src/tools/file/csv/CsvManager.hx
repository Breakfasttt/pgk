package tools.file.csv;

/**
 * ...
 * @author Breakyt
 */
class CsvManager 
{
	private var m_parser : CsvParser;

	private var m_parsedCsv : Map<String, CsvData>;
	
	public function new() 
	{
		m_parser = new CsvParser();
		m_parsedCsv = new Map();
	}
	
	public function parseAndRegisterCsv(id : String, csvFile : String) : Void
	{
		var result : CsvData = m_parser.parse(csvFile);
		if (result != null)
			m_parsedCsv.set(id, result);
	}
	
	public function getCsv(id : String) : CsvData
	{
		return m_parsedCsv.get(id);
	}
	
	public function getValue(csvId : String, rawId : String, columnName : String) : String
	{
		var csvData : CsvData = m_parsedCsv.get(csvId);
		if (csvData == null)
			return null;
			
		return csvData.getCell(rawId, columnName);
	}
}