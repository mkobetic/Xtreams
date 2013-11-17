"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testSignedLong
	| interpreting negative positive |
	stream := ByteArray new writing.
	negative := -268435456. "SmallInteger minVal // 2 in 32-bits"
	positive :=  268435455. "SmallInteger maxVal // 2 in 32-bits"
	interpreting := stream interpreting: #signedLong.
	interpreting put: negative.
	interpreting put: positive.
	interpreting := stream contents reading interpreting: #signedLong.
	self assert: interpreting get = negative.
	self assert: interpreting get = positive
