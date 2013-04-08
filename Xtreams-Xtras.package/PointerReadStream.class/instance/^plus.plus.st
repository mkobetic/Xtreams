"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
++ anInteger

	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available ifNil: [ anInteger ] ifNotNil: [ :available | available min: anInteger ].
	position := position + anInteger.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger