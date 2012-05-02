as yet unclassified
testOne
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '1'.
	self assert: number = 1