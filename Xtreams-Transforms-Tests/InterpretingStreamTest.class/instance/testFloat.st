"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testFloat
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #float.
	-50.0 to: 50.0 by: 0.5 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #float) rest = (-50 to: 50 by: 0.5) asArray
