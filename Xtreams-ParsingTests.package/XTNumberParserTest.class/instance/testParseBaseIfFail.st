as yet unclassified
testParseBaseIfFail
	| parser result |
	parser := XTNumberParser new.
	result := parser parse: '13' base: 12 ifFail: [42].
	self assert: result = 15.