structural
Sequence: nodes
	<action: 'Sequence'>

	nodes size = 1 ifTrue: [^nodes first].
	^'(generator Sequence: ', (self collection: nodes), ')'