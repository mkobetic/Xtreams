"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testUnsignedLongLong
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #longlong.
	(SmallInteger maxVal - 100) to: (SmallInteger maxVal + 100) do: [:each | interpreting put: each].
	self assert: ((stream contents reading interpreting: #longlong) rest isSameSequenceAs: ((SmallInteger maxVal - 100) to: (SmallInteger maxVal + 100)))
