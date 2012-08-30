lexical
NumLiteral: digit rest: digits
	<action: 'NumLiteral' arguments: #( 1 2 )>

	| number |
	digit = 'Infinity' ifTrue: [^PEGInfinity positive].
	digit = '0' ifTrue: [^0].
	number := String new writing.
	number put: digit.
	digits isEmpty ifFalse: [number write: digits].
	^number contents asNumber