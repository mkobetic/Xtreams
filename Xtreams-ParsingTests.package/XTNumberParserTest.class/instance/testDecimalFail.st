as yet unclassified
testDecimalFail
	| number parser |
	parser := XTNumberParser new.
	number := parser parse: '1.g23' ifFail: [99].
	self assert: number = 99