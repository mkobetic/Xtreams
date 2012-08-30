operations
all: expressions
	| result object position |
	position := stream position.
	result := Array new: expressions size.
	expressions keysAndValuesDo: [:index :expression |
		(object := expression value) == Failure
			ifTrue: [stream position: position. ^Failure].
		result at: index put: object].
	^result