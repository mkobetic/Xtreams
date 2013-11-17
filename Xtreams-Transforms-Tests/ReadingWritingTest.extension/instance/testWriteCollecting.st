"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testWriteCollecting
	| data |
	data := 1 to: 15.
	(self output collecting: [:e | e * e]) write: data.
	self assert: (self input read: data size) = (ByteArray withAll: (data collect: [:e | e * e]))
