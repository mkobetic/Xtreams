as yet unclassified
testTwelve
	| result |
	result := self printWith: [ :printer :out | printer print: 12 on: out ].
	self assert: result = '12'