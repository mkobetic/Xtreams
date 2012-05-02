as yet unclassified
testClassParse
	| number |
	number := XTNumberParser parse: '123'.
	self assert: number = 123