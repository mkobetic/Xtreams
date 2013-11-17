"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testUnsignedLong
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #long.
	65000 to: 70000 do: [:each | interpreting put: each].
	self assert: ((stream contents reading interpreting: #long) rest isSameSequenceAs: (65000 to: 70000))
