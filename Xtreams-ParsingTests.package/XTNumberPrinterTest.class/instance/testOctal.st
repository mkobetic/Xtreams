as yet unclassified
testOctal
	| result |
	result := self printWith: [:printer :stream | printer print: 56 on: stream base: 8].
	self assert: result = '70'.