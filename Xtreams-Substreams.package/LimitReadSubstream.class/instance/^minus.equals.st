"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-= anInteger
	| available |
	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: limit.
	source ++ (limit - position - available).
	position := limit - available.
	available = anInteger ifTrue: [^anInteger].
	^(Incomplete count: available) raise