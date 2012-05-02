as yet unclassified
testAA
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: 'aa' base: 16.
	self assert: number = 170
	