as yet unclassified
testNilIfFail
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: 'ccc'.
	self assert: number isNil