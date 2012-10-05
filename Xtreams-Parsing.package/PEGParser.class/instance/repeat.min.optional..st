operations
repeat: expression min: min optional: optional
	| result object position |
	position := stream position.
	result := OrderedCollection new: min.
	min timesRepeat:
		[(object := expression value) == Failure
			ifTrue: [stream position: position. ^Failure].
		result add: object].
	optional timesRepeat:
		[position := stream position.
		(object := expression value) == Failure
			ifTrue: [stream position: position. ^result].
		result add: object].
	^result