structural
Definition: identifier expression: expression
	<action: 'Definition' arguments: #( 2 6 )>

	| cache |
	useCache ifFalse: [ ^identifier -> [parser definition: expression name: identifier] ].

	parser caches add: (cache := Dictionary new).
	^identifier -> [parser definition: expression name: identifier cache: cache]