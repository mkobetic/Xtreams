"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: lexical
"
Identifier: first rest: rest
	<action: 'Identifier' arguments: #( 1 2 )>

	| stream |
	stream := (String new: rest size + 3) writing.
	stream put: $'.
	stream put: first.
	rest notEmpty ifTrue: [stream write: rest].
	stream put: $'.
	^stream contents