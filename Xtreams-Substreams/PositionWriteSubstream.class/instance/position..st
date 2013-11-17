"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position: anInteger
	| available adjustment |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].

	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: self length.
	adjustment := available - position.
	adjustment positive
		ifTrue: [ destination ++ adjustment ]
		ifFalse: [ destination -- adjustment negated ].
	position := available.
	available = anInteger ifTrue: [^anInteger].
	(Incomplete count: available) raise
