"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - enumeration
"
testDo

	| data result i |
	data := ByteArray withAll: (0 to: 15).
	self output write: data; close.
	result := ByteArray new: data size.
	i := 1.
	self input do: [ :e | result at: i put: e * e. i := i + 1 ].
	data with: result do: [ :in :out | self assert: in * in = out ]
