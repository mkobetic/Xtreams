as yet unclassified
testTwo
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '2'.
	self assert: number = 2