"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testWritePositioningInsert

	| message result |
	message := ByteArray withAll: (1 to: 20).
	(PositionWriteStream on: self output)
		write: message; write: message;
		+= message size;
		insert: message;
		-= 0;
		close.
	result := self input rest.
	self assert: result = (message, message, message)
