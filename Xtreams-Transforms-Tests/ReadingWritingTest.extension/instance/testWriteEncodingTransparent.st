"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - encoding
"
testWriteEncodingTransparent

	| data result bytes |
	bytes := #[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ].
	data := String withAll: (bytes asArray collect: [ :e | e asCharacter ]).
	(self output encoding: #ascii)
		setLineEndTransparent;
		write: data;
		close.
	result := self input read: data size.
	self assert: result = bytes
