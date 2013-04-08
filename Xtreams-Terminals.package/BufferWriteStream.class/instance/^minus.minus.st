"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := (destination writeSkip: anInteger negated) negated.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise