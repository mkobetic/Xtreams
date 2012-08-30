operations
anything
	| position |
	position := stream position.
	[stream read: 1 into: cache at: 1] on: Incomplete do: [stream position: position. ^Failure].
	^cache at: 1