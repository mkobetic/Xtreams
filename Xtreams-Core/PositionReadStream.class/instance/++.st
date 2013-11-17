"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
++ anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	skipped := buffer readSkip: anInteger.
	skipped = anInteger ifTrue: [^anInteger].
	[super ++ (anInteger - skipped)] on: Incomplete do: [:incomplete |
		(Incomplete count: incomplete count + skipped) raise].
	^anInteger
