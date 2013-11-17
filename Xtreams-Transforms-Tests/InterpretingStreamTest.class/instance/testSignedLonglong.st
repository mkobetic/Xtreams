"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testSignedLonglong
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedLonglong.
	interpreting put: (SmallInteger minVal // 2) - 1.
	interpreting put: (SmallInteger maxVal // 2) + 1.
	interpreting := stream contents reading interpreting: #signedLonglong.
	self assert: interpreting get = ((SmallInteger minVal // 2) - 1).
	self assert: interpreting get = ((SmallInteger maxVal // 2) + 1)
