seeking
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := anInteger min: position.
	count := [source -- count. count] on: Incomplete do: [ :ex | ex count ].
	position := position - count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	anInteger isZero ifFalse: [sourceAtEnd := false].
	^anInteger