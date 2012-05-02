as yet unclassified
testClassParseBase
	| number |
	number := XTNumberParser parse: '123' base: 8..
	self assert: number = 83