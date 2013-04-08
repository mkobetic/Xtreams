This is abstract superclass of all substreams. Substreams normally don't close their underlying source, their closing behavior is customized via closeBlock.

Instance Variables
	sourceAtEnd	<Boolean> flags end of the source
	closeBlock	<BlockClosure> unary block invoked in response to #close, allows customizing closing behavior

Note that slicing clones an initial prototype of a substream to create the slices and it uses #copy for that. The prototype is not used to read so it should remain in its properly initialized initial state. However if any of its instance variables contain mutable objects that change their state during reading, those must be copied as well. Make sure any concrete subclass defines an appropriate #postCopy method if needed.
