"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testRepeatingPattern

	| stream result |
	stream := '123-45--6789-abc--def' reading.
	result := (stream ending: '--') rest.
	self assert: result = '123-45'.
	result := (stream ending: '--') rest.
	self assert: result = '6789-abc'