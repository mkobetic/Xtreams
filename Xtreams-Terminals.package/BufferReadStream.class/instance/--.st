"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := (source readSkip: anInteger negated) negated.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
