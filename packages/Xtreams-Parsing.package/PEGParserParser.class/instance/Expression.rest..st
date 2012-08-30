structural
Expression: first rest: rest
	<action: 'Expression' arguments: #( 1 2 )>

	| sequences |
	rest isEmpty ifTrue: [^first].
	sequences := (Array with: first), (rest collect: [:each | each last]).
	^[parser any: sequences]