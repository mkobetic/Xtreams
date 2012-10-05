operations
definition: expression name: name
	| object position |
	position := stream position.
	object := expression value.
	object == Failure ifTrue: [^Failure].
	actor ifNil: [^object].
	^actor process: name object: object start: position stop: stream position