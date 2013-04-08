"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: operations
"
definition: expression name: name
	| object position |
	position := stream position.
	object := expression value.
	object == Failure ifTrue: [^Failure].
	actor ifNil: [^object].
	^actor process: name object: object start: position stop: stream position