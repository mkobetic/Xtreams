operations
definition: expression name: name cache: expressionCache
	| object position entry |
	position := stream position.
	entry := expressionCache at: position ifAbsentPut:
		[object := expression value.
		(object ~~ Failure and: [actor notNil]) ifTrue:
			[object := actor process: name object: object start: position stop: stream position].
		stream position -> object].
	stream position: entry key.
	^entry value