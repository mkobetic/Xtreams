"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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