"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
buffering: bufferSize
	"Delays committing its content to its underlying stream until it has reached a certain size ,#flush is sent, or the stream is closed."
	"       bufferSize      <Integer> The size of the buffer to start with.
		^<PositionWriteStream>"
	"
		(ByteArray new writing buffering: 5)
			write: (ByteArray withAll: (1 to: 11));
			conclusion
	"
	^BufferedWriteStream on: self bufferSize: bufferSize
