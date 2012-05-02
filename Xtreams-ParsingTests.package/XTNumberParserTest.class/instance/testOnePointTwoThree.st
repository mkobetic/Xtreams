as yet unclassified
testOnePointTwoThree
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '1.23'.
	self assert: number = 1.23s2