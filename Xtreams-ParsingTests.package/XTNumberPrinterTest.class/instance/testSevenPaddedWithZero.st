as yet unclassified
testSevenPaddedWithZero
	| result |
	result := self printWith: 
		[:printer :stream | 
		printer padTo: 3 with: $0.
		printer print: 7 on: stream base: 8].
	self assert: result = '007'