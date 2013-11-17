"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position: anInteger
	| delta available |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].

	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: self length.
	delta := available - position.
	[delta positive
		ifTrue: [source ++ delta]
		ifFalse:        [source -- delta negated]]
			on: Incomplete do: [sourceAtEnd := true].
	position := available.
	available = anInteger ifTrue: [^anInteger].
	(Incomplete count: available) raise
