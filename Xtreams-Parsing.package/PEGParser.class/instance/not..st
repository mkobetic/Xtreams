operations
not: expression
	| position object |
	position := stream position.
	object := expression value.
	stream position: position.
	^object == Failure
		ifTrue:	[nil]
		ifFalse:	[Failure]