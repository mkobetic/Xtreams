operations
repeat: expression min: min test: test
	| result object position |
	position := stream position.
	result := OrderedCollection new: min.
	min timesRepeat:
		[object := test value.
		stream position: position.
		object == Failure ifFalse: [^Failure].
		(object := expression value) == Failure
			ifTrue: [stream position: position. ^Failure].
		result add: object].
	[position := stream position.
	test value == Failure] whileTrue:
		[stream position: position.
		(object := expression value) == Failure
			ifTrue: [stream position: position. ^result].
		result add: object].
	^result