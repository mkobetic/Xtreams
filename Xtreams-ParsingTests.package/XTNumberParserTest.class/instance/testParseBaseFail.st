as yet unclassified
testParseBaseFail
	| parser result |
	parser := XTNumberParser new.
	result := parser parse: 'ccc' base: 12 ifFail: [42].
	self assert: result = 42.