"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testReadIntoCollection

	| data out |
	data := #[1 2 3 4 5 6 7].
	self output write: data; close.
	out := ByteArray new: data size.
	self assert: (self input read: 4 into: out) = 4.
	self assert: (self input read: 3 into: out at: 5)  = 3.
	self assert: out = data
