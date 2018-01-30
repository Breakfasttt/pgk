package tools.debug;

/**
 * Debug tools function to count the time of an algorythme execution.
 * @author Breakyt
 */
class ExecTimeCounter 
{

	private var m_startTimeStamp : Null<Float>;
	
	public var timeElapsed : Float; //in ms
	
	public function new() 
	{
		m_startTimeStamp = null;
		timeElapsed = -1.0;
	}
	
	/**
	 * Start the counter. Reset 'timeElapsed' public parameters
	 */
	public function start() : Void
	{
		m_startTimeStamp = Date.now().getTime();
		timeElapsed = -1.0;
	}
	
	/**
	 * Stop the counter. And set 'timeElapsed' public parameters if start() was call before this.
	 * Else timeElapsed = -1.0;
	 * Each time you call stop(), be carefull to call start() before.
	 */	
	public function stop() : Void
	{
		if (m_startTimeStamp != null)
		{
			timeElapsed = Date.now().getTime() - m_startTimeStamp;
			m_startTimeStamp = null;
		}
	}
	
}