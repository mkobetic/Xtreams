as yet unclassified
testFortyFivePointSix
	| result |
	result := self printWith: [:printer :stream | printer print: 45.6s1 on: stream].
	self assert: result = '45.6'