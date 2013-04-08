"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWorstCase

	| stream result |
	stream := 'abaabaaabaaaabaaaaabaaaabaaabaabab' reading.
	result := (stream ending: 'aaaaab') rest.
	self assert: result = 'abaabaaabaaaab'