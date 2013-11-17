"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - encoding
"
testReadDecodingTransparent

	| result bytes |
	bytes := #[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ].
	self output write: bytes; close.
	result := (self input encoding: #ascii) setLineEndTransparent read: bytes size.
	self assert: result = (String withAll: (bytes asArray collect: [ :e | e asCharacter ]))
