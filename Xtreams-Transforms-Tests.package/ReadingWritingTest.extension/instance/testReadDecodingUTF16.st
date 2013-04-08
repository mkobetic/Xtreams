"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - encoding
"
testReadDecodingUTF16

	| result bytes |
	bytes := #[0 72 0 101 0 108 0 108 0 111 0 32 0 87 0 111 0 114 0 108 0 100 0 33].
	self output write: bytes; close.
	result := (self input encoding: #utf16) read: 12.
	self assert: result = 'Hello World!'