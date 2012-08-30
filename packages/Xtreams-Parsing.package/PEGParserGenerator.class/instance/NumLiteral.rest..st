lexical
NumLiteral: digit rest: digits
	<action: 'NumLiteral' arguments: #( 1 2 )>

	| number |
	number := String new writing.
	number put: digit.
	digits isEmpty ifFalse: [number write: digits].
	^number contents