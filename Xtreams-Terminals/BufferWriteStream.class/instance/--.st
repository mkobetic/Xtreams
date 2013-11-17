"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := (destination writeSkip: anInteger negated) negated.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
