as yet unclassified
testTwelve
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '12'.
	self assert: number = 12