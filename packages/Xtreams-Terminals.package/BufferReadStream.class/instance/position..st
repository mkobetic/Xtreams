seeking
position: aPosition
	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: source activeSize.
	source readPosition: available.
	available = aPosition ifTrue: [^aPosition ].
	(Incomplete count: available) raise