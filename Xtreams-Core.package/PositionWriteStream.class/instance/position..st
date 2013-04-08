"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position: aPosition
	| startPosition delta |
	aPosition < 0 ifTrue: [Incomplete zero raise].
	startPosition := buffer writePosition.
	delta := aPosition - startPosition.
	^[	self ++ delta. aPosition
	] on: Incomplete do: [ :ex |
		(Incomplete count: startPosition + ex count) raise ]