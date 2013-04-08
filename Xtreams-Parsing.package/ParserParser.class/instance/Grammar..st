"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: structural
"
Grammar: definitions
	<action: 'Grammar' arguments: #( 1 )>

	| defines |
	defines := Dictionary new.
	defines addAll: definitions.
	references keysAndValuesDo: [:name :dummy | dummy become: (defines at: name)].

	parser grammar addAll: references.
	defines keysAndValuesDo: [:name :definition | definition class == Object ifFalse: [parser grammar at: name put: definition]].
	^parser