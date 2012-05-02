as yet unclassified
testOnePointTwo
	| result |
	result := self printWith: [:printer :stream | printer print: 1.2s1 on: stream].
	self assert: result = '1.2'