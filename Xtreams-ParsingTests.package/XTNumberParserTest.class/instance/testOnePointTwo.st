as yet unclassified
testOnePointTwo
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '1.2'.
	self assert: number = 1.2s1