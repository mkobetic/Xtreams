"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: operations
"
excluding: intervals
	| position integer |
	position := stream position.
	[stream read: 1 into: cache at: 1] on: Incomplete do: [stream position: position. ^Failure].
	integer := (cache at: 1) asInteger.
	intervals do: [:interval | (interval includes: integer) ifTrue: [stream position: position. ^Failure]].
	^cache at: 1