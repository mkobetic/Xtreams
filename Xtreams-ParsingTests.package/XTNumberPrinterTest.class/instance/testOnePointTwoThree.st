as yet unclassified
testOnePointTwoThree
	| result |
	result := self printWith: [:printer :stream | printer print: 1.23s2 on: stream].
	self assert: result = '1.23'