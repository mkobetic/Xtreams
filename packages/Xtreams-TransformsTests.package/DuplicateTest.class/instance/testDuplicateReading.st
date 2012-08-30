testing
testDuplicateReading
	| copy |
	copy := Array new writing.
	self assert: ((0 to: 255) reading duplicating: copy) rest = copy conclusion