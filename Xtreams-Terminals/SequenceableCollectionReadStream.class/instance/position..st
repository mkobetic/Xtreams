"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position: aPosition

	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	position := aPosition min: self length.
	position = aPosition ifTrue: [^aPosition ].
	(Incomplete count: position) raise
