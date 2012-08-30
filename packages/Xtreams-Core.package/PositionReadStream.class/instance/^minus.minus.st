seeking
-- anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	skipped := (buffer readSkip: anInteger negated) negated.
	skipped = anInteger ifTrue: [^anInteger].
	(Incomplete count: skipped) raise