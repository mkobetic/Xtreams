"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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