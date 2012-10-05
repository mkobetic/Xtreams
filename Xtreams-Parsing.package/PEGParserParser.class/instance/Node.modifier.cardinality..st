structural
Node: primary modifier: modifier cardinality: cardinality
	<action: 'Node' arguments: #( 2 1 3 )>

	| expression |
	expression := primary.
	cardinality ifNotNil: [expression := cardinality value: expression].
	modifier ifNotNil: [expression := modifier value: expression].
	^expression