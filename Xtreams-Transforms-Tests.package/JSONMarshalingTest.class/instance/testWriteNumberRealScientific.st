"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteNumberRealScientific

	| stream result |
	stream := String new writing marshaling: JSON.
	stream put: 10 ** -6.
	result := stream close; terminal.
	self assert: result = '1.0e-6'