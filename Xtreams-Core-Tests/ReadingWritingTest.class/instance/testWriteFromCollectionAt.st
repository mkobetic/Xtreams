"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testWriteFromCollectionAt

	| data |
	data := #[1 2 3 4 5 6 7].
	self assert: (self output write: 4 from: data at: 1) = 4.
	self assert: (self input read: 4) = (data first: 4).
	self assert: (self output write: 3 from: data at: 5) = 3.
	self assert: (self input read: 3) = (data last: 3)
