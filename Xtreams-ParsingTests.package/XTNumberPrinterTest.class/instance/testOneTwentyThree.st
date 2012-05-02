as yet unclassified
testOneTwentyThree
	| result |
	result := self printWith: [ :printer :out | printer print: 123 on: out ].
	self assert: result = '123'