"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testSignedChar
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedChar.
	-120 to: 120 do: [:each | interpreting put: each].
	interpreting := stream contents reading interpreting: #signedChar.
	self assert: interpreting rest = (-120 to: 120) asArray
