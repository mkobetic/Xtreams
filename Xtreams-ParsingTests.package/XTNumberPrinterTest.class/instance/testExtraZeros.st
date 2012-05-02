as yet unclassified
testExtraZeros
	| result |
	result := self printWith: 
		[:printer :stream | 
		printer print: 1.23s7 on: stream].
	self assert: result = '1.2300000'