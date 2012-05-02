as yet unclassified
testFloat
	| result |
	result := self printWith: 
		[:printer :stream | 
		printer print: 1.5 on: stream].
	self assert: result = '1.5'