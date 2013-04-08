"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testSimplePattern

	| stream result |
	stream := '112123456' reading.
	result := (stream ending: '123') rest.
	self assert: result = '112'