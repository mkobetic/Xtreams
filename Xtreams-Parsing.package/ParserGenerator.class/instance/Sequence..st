"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: structural
"
Sequence: nodes
	<action: 'Sequence'>

	nodes size = 1 ifTrue: [^nodes first].
	^'(generator Sequence: ', (self collection: nodes), ')'