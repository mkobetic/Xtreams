lexical
Identifier: first rest: rest
	<action: 'Identifier' arguments: #( 1 2 )>

	| stream |
	stream := (String new: rest size + 1) writing.
	stream put: first.
	rest notEmpty ifTrue: [stream write: rest].
	^stream contents