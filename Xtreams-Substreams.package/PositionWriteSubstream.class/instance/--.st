"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := anInteger min: position.
	count := [destination -- count. count] on: Incomplete do: [ :ex | ex count ].
	position := position - count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	anInteger isZero ifFalse: [destinationAtEnd := false].
	^anInteger