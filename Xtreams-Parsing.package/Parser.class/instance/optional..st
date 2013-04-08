"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: operations
"
optional: expression
	| object |
	^(object := expression value) == Failure
		ifTrue:	[nil]
		ifFalse:	[object]