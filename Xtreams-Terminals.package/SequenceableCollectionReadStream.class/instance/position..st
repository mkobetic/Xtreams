seeking
position: aPosition

	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	position := aPosition min: self length.
	position = aPosition ifTrue: [^aPosition ].
	(Incomplete count: position) raise