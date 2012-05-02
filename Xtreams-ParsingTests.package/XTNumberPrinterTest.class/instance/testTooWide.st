as yet unclassified
testTooWide
	| result |
	result := self printWith: 
		[:printer :stream | 
		printer padTo: 3 with: $x.
		printer print: 1.23s2 on: stream].
	self assert: result = '1.23'