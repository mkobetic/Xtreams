seeking
position: aPosition
	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: destination activeSize.
	destination writePosition: available.
	available = aPosition ifTrue: [^aPosition ].
	(Incomplete count: available) raise