seeking
++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	count := [source ++ count. count] on: Incomplete do: [ :ex | ex count ].
	position := position + count.
	count < anInteger ifTrue: [sourceAtEnd := true. (Incomplete count: count) raise].
	^anInteger