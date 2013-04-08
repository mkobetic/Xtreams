"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
testWritingChars

	| string result |
	self prepareChars.
	stream put: Character tab.
	self assert: (stream terminal at: 0) = Character tab asInteger.
	string := 'Hello World!'.
	stream write: string.
	result := ByteString new: string size.
	stream terminal copyAt: 1 to: result size: string size startingAt: 1. 
	self assert: string = result.
	stream close.
	self assert: stream length = (string size + 1).