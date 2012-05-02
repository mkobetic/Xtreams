as yet unclassified
testDecimalPlaces
	| result |
	result := self printWith: 
		[:printer :stream | 
		printer decimalPlaces: 12.
		printer print: 11/7 on: stream].
	self assert: result = '1.571428571428'