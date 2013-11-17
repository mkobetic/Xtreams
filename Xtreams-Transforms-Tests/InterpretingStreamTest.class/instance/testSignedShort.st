"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testSignedShort
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedShort.
	interpreting put: -31000.
	interpreting put: 31000.
	interpreting := stream contents reading interpreting: #signedShort.
	self assert: interpreting get = -31000.
	self assert: interpreting get = 31000
