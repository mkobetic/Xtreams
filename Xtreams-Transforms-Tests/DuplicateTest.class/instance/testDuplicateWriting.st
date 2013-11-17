"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testDuplicateWriting
	| original copy |
	original := ByteArray new writing.
	copy := ByteArray new writing.
	(original duplicating: copy) write: (0 to: 255).
	self assert: original conclusion = copy conclusion
