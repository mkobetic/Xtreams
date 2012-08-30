terminals
Literal: characters
	<action: 'Literal' arguments: #( 2 )>

	| stream |
	stream := String new writing.
	stream write: '(generator Literal: '''.
	(stream transforming: [:in :out | | each |
		each := in get.
		each = $' ifTrue: [out put: $'].
		out put: each]) write: characters.
	stream write: ''')'.
	^stream contents