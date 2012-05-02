transforming
buffering: bufferSize
	"Delays committing its content to its underlying stream until it has reached a certain size ,#flush is sent, or the stream is closed."
	"	bufferSize	<Integer> The size of the buffer to start with.
		^<PositionWriteStream>"
	"
		(ByteArray new writing buffering: 5)
			write: (ByteArray withAll: (1 to: 11));
			conclusion
	"
	^XTBufferedWriteStream on: self bufferSize: bufferSize