tests - seeking
testWritePositioningInsert

	| message result |
	message := ByteArray withAll: (1 to: 20).
	(XTPositionWriteStream on: self output)
		write: message; write: message;
		+= message size;
		insert: message;
		-= 0;
		close.
	result := self input rest.
	self assert: result = (message, message, message)