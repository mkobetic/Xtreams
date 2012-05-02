as yet unclassified
testOctal
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '70' base: 8.
	self assert: number = 56
	
