"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - enumeration
"
testSelect

	| data result |
	data := ByteArray withAll: (0 to: 15).
	self output write: data; close.
	result := self input select: [ :e | e odd ].
	self assert: result = (data select: [ :e | e odd ]).
