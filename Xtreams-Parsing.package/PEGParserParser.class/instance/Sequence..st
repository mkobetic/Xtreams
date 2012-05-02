structural
Sequence: nodes
	<action: 'Sequence'>

	nodes size = 1 ifTrue: [^nodes first].
	^[parser all: nodes]