seeking
position: aPosition

	| startPosition delta |
	aPosition < 0 ifTrue: [Incomplete zero raise].
	startPosition := buffer readPosition.
	delta := aPosition - startPosition.
	^[	self ++ delta. aPosition
	] on: Incomplete do: [ :ex |
		(Incomplete count: startPosition + ex count) raise ]