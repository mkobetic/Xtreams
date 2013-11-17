"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-- anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	skipped := (buffer readSkip: anInteger negated) negated.
	skipped = anInteger ifTrue: [^anInteger].
	(Incomplete count: skipped) raise
