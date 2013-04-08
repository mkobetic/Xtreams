"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteObjectPoint

	| stream result |
	stream := String new writing marshaling: JSON.
	stream put: 3 @ 4.
	result := stream
				close;
				terminal.
	self assert: result = '{"x": 3, "y": 4}'