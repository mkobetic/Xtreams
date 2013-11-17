"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testDuplicateReadingIncomplete
	| original copy |
	copy := ByteArray new writing.
	[(#[0 1 2 3 4 5 6 7 8 9] reading duplicating: copy) read: 20] on: Incomplete do: [:incomplete | original := incomplete contents].
	copy := copy conclusion.
	self assert: original = #[0 1 2 3 4 5 6 7 8 9].
	self assert: copy = #[0 1 2 3 4 5 6 7 8 9]
