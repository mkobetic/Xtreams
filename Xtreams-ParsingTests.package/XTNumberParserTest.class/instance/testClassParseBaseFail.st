as yet unclassified
testClassParseBaseFail
	| number |
	number := XTNumberParser parse: 'zz123' base: 8 ifFail: [25].
	self assert: number = 25