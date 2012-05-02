as yet unclassified
testNilIfFailBase8
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: 'ccc' base: 8.
	self assert: number isNil