as yet unclassified
testTwelveSpace
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '12'.
	self assert: number = 12