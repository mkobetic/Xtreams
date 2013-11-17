"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - encoding
"
testReadDecodingCRLF

	| result |
	self output write: #[104 101 108 108 111 13 10 119 111 114 108 100 10 13 13 10 10 ]; close.
	result := (self input encoding: #ascii) read: 15.
	self assert: result = 'hello\world\\\\' withCRs
