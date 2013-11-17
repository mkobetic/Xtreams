"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testWriteCollection

	| data |
	data := #[1 2 3 4 5 6 7].
	self assert: (self output write: data) = data size.
	self assert: (self input read: data size) = data
