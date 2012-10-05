seeking
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := (source readSkip: anInteger negated) negated.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise