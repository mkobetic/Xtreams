tests - seeking
testWritePositioningWithRingBuffer

	| message result |
	message := ByteArray withAll: (1 to: 20).
	(XTPositionWriteStream on: self output)
		buffer: (XTRingBuffer on: (ByteArray new: 5));
		write: message;
		close.
	result := self input rest.
	self assert: result = message