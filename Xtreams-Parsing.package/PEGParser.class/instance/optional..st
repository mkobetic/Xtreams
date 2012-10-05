operations
optional: expression
	| object |
	^(object := expression value) == Failure
		ifTrue:	[nil]
		ifFalse:	[object]