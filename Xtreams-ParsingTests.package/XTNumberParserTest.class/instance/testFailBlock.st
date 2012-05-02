as yet unclassified
testFailBlock
	| parser result |
	parser := XTNumberParser new.
	result := parser parse: 'abc' ifFail: [42].
	self assert: result = 42.