This is abstract superclass of all substreams. Substreams normally don't close their underlying source, their closing behavior is customized via closeBlock.

Instance Variables
	destinationAtEnd	<Boolean> flags end of the destination
	closeBlock	<BlockClosure> unary block invoked in response to #close, allows customizing closing behavior
	substreamClosed	<Boolean> flags the end of the receiver

