as yet unclassified
testFraction
	| result |
	result := self printWith:
		[:printer :stream | 
		printer print: 3/2 on: stream].
	self assert: result = '1.5'