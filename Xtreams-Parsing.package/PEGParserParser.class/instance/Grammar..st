structural
Grammar: definitions
	<action: 'Grammar' arguments: #( 1 )>

	| defines |
	defines := Dictionary new.
	definitions do: [ :each | defines at: each key put: each value ].
	references keysAndValuesDo: [:name :dummy | dummy become: (defines at: name)].

	parser grammar addAll: references.
	defines keysAndValuesDo: [:name :definition | definition class == Object ifFalse: [parser grammar at: name put: definition]].
	^parser