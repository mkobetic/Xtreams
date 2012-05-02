*Xtreams-TransformsTests-encoding
testWriteEncodingTransparent

	| data result bytes |
	bytes := #[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ].
	data := String withAll: (bytes asArray collect: #asCharacter).
	(self output encoding: #ascii)
		setLineEndTransparent;
		write: data;
		close.
	result := self input read: data size.
	self assert: result = bytes