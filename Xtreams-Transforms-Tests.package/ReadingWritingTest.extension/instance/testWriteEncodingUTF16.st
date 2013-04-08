"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - encoding
"
testWriteEncodingUTF16

	| result bytes |
	bytes := #[0 72 0 101 0 108 0 108 0 111 0 32 0 87 0 111 0 114 0 108 0 100 0 33].
	(self output encoding: #utf16) write: 'Hello World!'; close.
	result := self input read: 24.
	self assert: result = bytes