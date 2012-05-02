as yet unclassified
testOneTwentyThree
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '123'.
	self assert: number = 123