"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-- anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	skipped := (buffer readSkip: anInteger negated) negated.
	skipped = anInteger ifTrue: [^anInteger].
	(Incomplete count: skipped) raise
