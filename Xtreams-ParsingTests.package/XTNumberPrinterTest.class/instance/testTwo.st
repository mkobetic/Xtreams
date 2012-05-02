as yet unclassified
testTwo
	| result |
	result := self printWith: [ :printer :out | printer print: 2 on: out ].
	self assert: result = '2'