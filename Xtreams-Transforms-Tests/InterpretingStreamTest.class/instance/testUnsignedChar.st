"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testUnsignedChar
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #char.
	0 to: 255 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #char) rest = (0 to: 255) asByteArray
