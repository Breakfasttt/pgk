package input.pointerImpl;

/**
 * @author Breakyt
 */
typedef BasicPointerSignals =
#if android
	BasicMouseSignals; // todo
#else
	BasicMouseSignals;
#end