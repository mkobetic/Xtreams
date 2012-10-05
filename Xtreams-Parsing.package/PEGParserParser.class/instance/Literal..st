terminals
Literal: characters
	<action: 'Literal' arguments: #( 2 )>

	| stream literal |
	stream := (String new: characters size) writing.
	characters do: [:each | stream put: each].
	literal := stream contents.
	parser bufferSize: literal size.
	^[parser literal: literal]