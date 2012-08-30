operations
any: expressions
	| position object |
	position := stream position.
	expressions do: [:expression |
		(object := expression value) == Failure
			ifTrue:	[stream position: position]
			ifFalse:	[^object]].
	stream position: position.
	^Failure