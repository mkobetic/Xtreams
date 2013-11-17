"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-= anInteger
	| available |
	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: limit.
	destination ++ (limit - position - available).
	position := limit - available.
	available = anInteger ifTrue: [^anInteger].
	^(Incomplete count: available) raise
