package input.pointerImpl;

/**
 * @author Breakyt
 */
typedef BasicPointerSignals =
#if android
	BasicTouchSignals;
#else
	BasicMouseSignals;
#end