"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testDuplicateWritingIncomplete
	| original copy |
	original := ByteArray new writing.
	copy := ByteArray new writing.
	[((original limiting: 10) duplicating: copy) write: (0 to: 255)] on: Incomplete do: [:incomplete | ].
	original := original conclusion.
	copy := copy conclusion.
	self assert: original = #[0 1 2 3 4 5 6 7 8 9].
	self assert: copy = #[0 1 2 3 4 5 6 7 8 9]
