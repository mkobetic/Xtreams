"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteString

	| stream result |
	stream := String new writing marshaling: JSON.
	stream put: 'hello'.
	result := stream close; terminal.
	self assert: result = '"hello"'