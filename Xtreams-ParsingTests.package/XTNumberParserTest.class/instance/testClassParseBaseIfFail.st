as yet unclassified
testClassParseBaseIfFail
	| number |
	number := XTNumberParser parse: '123' base: 8 ifFail: [25].
	self assert: number = 83