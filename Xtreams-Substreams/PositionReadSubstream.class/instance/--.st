"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := anInteger min: position.
	count := [source -- count. count] on: Incomplete do: [ :ex | ex count ].
	position := position - count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	anInteger isZero ifFalse: [sourceAtEnd := false].
	^anInteger
