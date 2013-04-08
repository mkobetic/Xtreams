"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteNumber

	| stream result |
	stream := String new writing marshaling: JSON.
	stream put: 42.
	result := stream close; terminal.
	self assert: result = '42'