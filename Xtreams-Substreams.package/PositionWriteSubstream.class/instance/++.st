"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	count := [destination ++ count. count] on: Incomplete do: [ :ex | ex count ].
	position := position + count.
	count < anInteger ifTrue: [destinationAtEnd := true. (Incomplete count: count) raise].
	^anInteger
