as yet unclassified
testZero
	| result |
	result := self printWith: [:printer :stream | printer print: 0 on: stream].
	self assert: result = '0'