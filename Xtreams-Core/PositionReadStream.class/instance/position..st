"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position: aPosition

	| startPosition delta |
	aPosition < 0 ifTrue: [Incomplete zero raise].
	startPosition := buffer readPosition.
	delta := aPosition - startPosition.
	^[      self ++ delta. aPosition
	] on: Incomplete do: [ :ex |
		(Incomplete count: startPosition + ex count) raise ]
