"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: structural
"
Node: primary modifier: modifier cardinality: cardinality
	<action: 'Node' arguments: #( 2 1 3 )>

	(modifier isNil and: [cardinality isNil]) ifTrue: [^primary].
	^'(generator Node: ', primary,
		' modifier: ', (modifier ifNil: ['nil'] ifNotNil: [modifier]),
		' cardinality: ', (cardinality ifNil: ['nil'] ifNotNil: [cardinality]), ')'