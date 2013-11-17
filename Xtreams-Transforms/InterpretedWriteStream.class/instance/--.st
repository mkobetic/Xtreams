"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: seeking
"
-- anInteger
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	[destination -- anInteger * elementSize]
		on: Incomplete do: [:exception | (Incomplete count: exception count / elementSize) raise].
	^anInteger
