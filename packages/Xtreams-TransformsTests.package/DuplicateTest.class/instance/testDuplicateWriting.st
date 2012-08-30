testing
testDuplicateWriting
	| original copy |
	original := ByteArray new writing.
	copy := ByteArray new writing.
	(original duplicating: copy) write: (0 to: 255).
	self assert: original conclusion = copy conclusion