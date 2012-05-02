as yet unclassified
testOnePaddedWithSpace
	| result |
	result := self printWith:
		[:printer :stream | 
		printer padTo: 3 with: Character space.
		printer print: 1 on: stream].
	self assert: result = '  1'