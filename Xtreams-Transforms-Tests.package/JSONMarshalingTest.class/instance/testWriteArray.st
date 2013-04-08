"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteArray

	| stream result |
	stream := String new writing marshaling: JSON.
	stream put: #[1 2 3].
	result := stream
				close;
				terminal.
	self assert: result = '[1, 2, 3]'