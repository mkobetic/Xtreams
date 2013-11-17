"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position: aPosition
	| available |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: self length.
	destination seekTo: available from: #begin.
	position := available.
	available = aPosition ifTrue: [ ^aPosition ].
	(Incomplete count: available) raise
