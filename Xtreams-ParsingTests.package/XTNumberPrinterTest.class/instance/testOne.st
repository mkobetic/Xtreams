as yet unclassified
testOne
	| result |
	result := self printWith: [:printer :stream | printer print: 1 on: stream].
	self assert: result = '1'