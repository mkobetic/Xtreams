"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testWritePositioningWithRingBuffer

	| message result |
	message := ByteArray withAll: (1 to: 20).
	(PositionWriteStream on: self output)
		buffer: (RingBuffer on: (ByteArray new: 5));
		write: message;
		close.
	result := self input rest.
	self assert: result = message
