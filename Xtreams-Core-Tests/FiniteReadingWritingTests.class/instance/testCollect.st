"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - enumeration
"
testCollect

	| data result |
	data := ByteArray withAll: (0 to: 15).
	self output write: data; close.
	result := self input collect: [ :e | e * e ].
	self assert: result size = data size.
	data with: result do: [ :in :out | self assert: in * in = out ]
