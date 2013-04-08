"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: operations
"
not: expression
	| position object |
	position := stream position.
	object := expression value.
	stream position: position.
	^object == Failure
		ifTrue:	[nil]
		ifFalse:	[Failure]