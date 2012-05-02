as yet unclassified
testInfiniteFraction
	| result |
	result := self printWith:
		[:printer :stream | 
		printer print: 1/3 on: stream].
	self assert: result = '0.33333333'