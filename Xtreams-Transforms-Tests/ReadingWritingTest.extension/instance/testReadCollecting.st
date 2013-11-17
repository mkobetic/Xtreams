"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testReadCollecting
	| data |
	data := #[ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ].
	self output write: data.
	self assert: ((self input collecting: [:e | e * e]) read: data size) = (ByteArray withAll: (data collect: [:e | e * e]))
