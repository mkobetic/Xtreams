as yet unclassified
testAA
	| result |
	result := self printWith: [:printer :stream | printer print: 170 on: stream base: 16].
	self assert: result = 'aa'