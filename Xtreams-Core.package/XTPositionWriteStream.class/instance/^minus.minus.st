seeking
-- anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	skipped := (buffer writeSkip: anInteger negated) negated.
	skipped = anInteger ifTrue: [^anInteger].
	(Incomplete count: skipped) raise