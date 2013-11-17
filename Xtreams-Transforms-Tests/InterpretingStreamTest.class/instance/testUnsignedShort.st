"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testUnsignedShort
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #short.
	250 to: 270 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #short) rest asArray = (250 to: 270) asArray
