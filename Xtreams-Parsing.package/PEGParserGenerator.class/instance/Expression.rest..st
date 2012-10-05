structural
Expression: first rest: rest
	<action: 'Expression' arguments: #( 1 2 )>

	rest isEmpty ifTrue: [^first].
	^'(generator Expression: ', first, ' rest: ', (self collection: (rest collect: [:each | '(Array with: ''/'' with: #() with: ', each last, ')'])), ')'